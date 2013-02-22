require 'util'

class Konfig < ActiveRecord::Base
  attr_accessible :key, :owner, :value

  #class << self; attr_accessor :konfigs end

  after_save     :reload
  after_destroy  :reload

  KONFIGS = Hash.new


  def self.reconfigure
    if KONFIGS[ :debug ]
      Applog.info 'Reloading Konfigs'
    end
    KONFIGS.clear
    Konfig.all.each { |k| KONFIGS[ k.key.to_sym ] = k.value }
    convertValues

    # Reconfiguring dependent models

  end

  def self.convertValues
    KONFIGS[ :debug ] = KONFIGS[ :debug ] && KONFIGS[ :debug ].downcase == 'true' ? true : false

    # Host name used in email notifications as access address to RIRA
    if !Konfig::KONFIGS[ :hostName ]
      begin
        Konfig::KONFIGS[ :hostName ] = Util::getMyFirstPrivateIPv4.ip_address
      rescue
        Konfig::KONFIGS[ :hostName ] = 'rirahost.app'
      end
    end

    # Access protocol that is used to use RIRA
    # Used in email notification as prefix of hostname
    # enable HTTPS/SSL for secure connectivity
    if !Konfig::KONFIGS[ :accessProtocol ]
      Konfig::KONFIGS[ :accessProtocol ] = 'http'
    end

    # Timeout for auto logout if no activity happens on session
    if !Konfig::KONFIGS[ :sessionInactivityTimeout ]
      Konfig::KONFIGS[ :sessionInactivityTimeout ] = 1800
    else
      begin
        Konfig::KONFIGS[ :sessionInactivityTimeout ] = Integer( Konfig::KONFIGS[ :sessionInactivityTimeout ] )
      rescue
        Applog.error "Wrong konfig value for sessionInactivityTimeout [#{Konfig::KONFIGS[ :sessionInactivityTimeout ]}]"
        Konfig::KONFIGS[ :sessionInactivityTimeout ] = 1800
      end
    end

    # Default homepage
    if !Konfig::KONFIGS[ :defaultHomePage ]
      Konfig::KONFIGS[ :defaultHomePage ] = "/"
    end

    # Default number of failed login is 0, means no checking
    if Konfig::KONFIGS[ :allowedFailedLogin ]
      begin
        Konfig::KONFIGS[ :allowedFailedLogin ] = Integer( Konfig::KONFIGS[ :allowedFailedLogin ] )
      rescue
        Applog.error "Wrong konfig value for allowedFailedLogin [#{Konfig::KONFIGS[ :allowedFailedLogin ]}]"
        Konfig::KONFIGS[ :allowedFailedLogin ] = 0
      end
    else
      Konfig::KONFIGS[ :allowedFailedLogin ] = 0
    end

    # Default number of days for password expiry extension
    if Konfig::KONFIGS[ :passwordExpiryExtension ]
      begin
        Konfig::KONFIGS[ :passwordExpiryExtension ] = Integer( Konfig::KONFIGS[ :passwordExpiryExtension ] )
      rescue
        Applog.error "Wrong konfig value for passwordExpiryExtension [#{Konfig::KONFIGS[ :passwordExpiryExtension ]}]"
        Konfig::KONFIGS[ :passwordExpiryExtension ] = 0
      end
    else
      Konfig::KONFIGS[ :passwordExpiryExtension ] = 90
    end

    #puts Konfig::KONFIGS
  end

  Konfig.reconfigure


  private
    def reload
      Konfig.reconfigure
    end

end
