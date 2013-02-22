require 'openssl'
require 'base64'
require 'aes'

module Util

  APP_LOG_PATH = './log/'

  def normalize( msisdn, nat=true, cc='98' )
    msisdn = msisdn.strip
    norm = ''
    if /\A00/.match( msisdn )
        norm = msisdn[ (2 + cc.length)..msisdn.length ]
    elsif /\A0[1-9]/.match( msisdn )
        norm = msisdn[ 1..msisdn.length ]
    elsif /\A\+/.match( msisdn )
        norm = msisdn[ (1 + cc.length)..msisdn.length ]
    elsif /\A#{cc}/.match( msisdn )
        norm = msisdn[ cc.length..msisdn.length ]
    else
        norm = msisdn
      #print 'E'
    end

    if nat
        return norm	# return national format
    else
      return cc + norm
    end
  end

  def getMyFirstPrivateIPv4
    Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  end

  def getMyFirstPublicIPv4
    Socket.ip_address_list.detect{|intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast? and !intf.ipv4_private?}
  end


  #### Application Logging
  class AppLogger < Logger

    def format_message( severity, timestamp, progname, msg )
      "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
    end

  end

  logfile = File.open( APP_LOG_PATH + '/rira.log', 'a'  )
  logfile.sync = true
  Applog = AppLogger.new( logfile )

  ###################################

  ####### Auditing ##################

  # Sample usage
  # Auditlog( self.class.name, nodep )

  def Auditlog( mo, msg )
    auditEntry = Audit.new
    auditEntry.message = "#{mo} #{caller[0][/`.*'/][1..-2]} #{msg.inspect}"
    #auditEntry.origin = ip
    auditEntry.origin = request.remote_ip
    auditEntry.user = !current_user.nil? ? current_user.email : 'no-user'
    auditEntry.datetime = DateTime.now

    if !auditEntry.save
      _auditLog.info "#{user} #{ip} #{caller[0][/`.*'/][1..-2]} #{msg.inspect}"
    end

  end

  class AuditLogger < Logger

    def format_message( severity, timestamp, progname, msg )
      "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
    end

  end

  auditfile = File.open( Util::APP_LOG_PATH + '/audit.log', 'a' )
  auditfile.sync = true
  _auditLog = AuditLogger.new( auditfile )

  ###################################

  def friendly_filename( filename )
    filename.gsub(/[^\w\s_-]+/, '')
    .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
    .gsub(/\s+/, '_')
  end

  # It is used for browser login credentials encryption (like SDP roll out and main login )
  # Login JS files have to be updated in case of changing PK files
  class RSAHelper

    class << self
      attr_accessor :prk, :phr, :digest, :key
    end


    def self.reload
      #if Konfig::KONFIGS[:debug]
      Applog.info 'Reloading RSA'
      #end
      begin
        RSAHelper.prk = File.read( Rails.root.to_s + '/config/pr.key' )
        RSAHelper.phr = Base64.decode64 'b21pZHJpcmE='
        RSAHelper.digest = OpenSSL::Digest::SHA256.new
        RSAHelper.key = OpenSSL::PKey::RSA.new RSAHelper.prk, RSAHelper.phr
      rescue => err
        Applog.error "Error on initializing security keys"
        Applog.error err.message
        Applog.error err.backtrace.join("\n")
      end
    end

    def self.decrypt( msg )
      RSAHelper.key.private_decrypt Base64.decode64 msg
    end

    def self.encrypt( msg )
      Base64.encode64( RSAHelper.key.public_encrypt msg )
    end

    def self.encryptHex( msg )
      RSAHelper.key.public_encrypt msg
    end

    def self.sign( msg )
      return Base64.encode64( RSAHelper.key.sign RSAHelper.digest, msg )
    end

    def self.signHex( msg )
      return RSAHelper.key.sign digest, msg
    end

    def self.verify( msg, signature )
      return RSAHelper.key.verify( RSAHelper.digest, Base64.decode64( signature ), msg )
    end

    def self.modulus
      return RSAHelper.key.public_key.n.to_s 16
    end

    def self.public_exp
      RSAHelper.key.public_key.e.to_s 16
    end

  # Initialize the security
  RSAHelper.reload

  end


  # It is used for node password and license check obfuscating
  class AESHelper

    class << self
      attr_accessor :h1
    end

    def self.reload
      #if Konfig::KONFIGS[:debug]
      Applog.info 'Reloading AES'
      #end
      AESHelper.h1 = AES.decrypt( 'vjirNB42KDgq4Vyz1z4ZVw==$9B0IeWaT1QKFmNyELbW+hw==', '' )
    end

    def self.encrypt( msg )
      AES.encrypt msg, AESHelper.h1
    end

    def self.decrypt( msg )
      AES.decrypt msg, AESHelper.h1
    end

    class << self
      alias :prepare :decrypt
    end

    AESHelper.reload

  end


end