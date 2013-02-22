require 'digest'

#class UserCache
#  attr_accessor :id, :email, :roles, :rights, :applets
#
#  def initialize( id, email, roles, rights, apps )
#    self.id = id
#    self.email = email
#    self.roles = roles
#    self.rights = rights
#    self.applets = apps
#  end
#
#end


class User < ActiveRecord::Base
  attr_accessible :email, :name, :pswd, :password, :password_confirmation
  attr_accessor :password
  attr_protected :expiry, :lock, :account_expiry, :failed

  #class << self; attr_accessor :users end

  #after_save :upd_usr
  #after_destroy :dest_usr

  has_many :microposts #, :dependent => :destroy
  has_many :jobs, :foreign_key => 'userId'
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  has_many :rights, :through => :roles
  has_many :applets, :through => :rights

  before_save :encrypt_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
            :length => { :maximum => 50 }

  validates :email, :presence => true,
            :format => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }

  validates :password, :presence => true, :on => :create,
            :confirmation => true,
            :length => { :within => 6..40 }

  validates :password, :presence => true, :on => :update, :if => Proc.new { |user| !user.password.blank? },
            :confirmation => true,
            :length => { :within => 6..40 }



  def has_password?( submitted_password )
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    pswd == "omtv1" + encrypt( submitted_password )
  end

  def self.authenticate( email, submitted_password )
    #user = find_by_email(email) #changed to support case-insensitive email
    user = User.first( :conditions => [ "lower(email) = ?", email.downcase ] )
    return nil if user.nil?
    return user.clearLoginFailed if user.has_password?( submitted_password ) else user.loginFailed
  end

  def self.authenticate_with_salt( id, cookie_salt )
    user = find_by_id( id )
    ( user && user.salt == cookie_salt && !user.lock ) ? user : nil
  end

  # Increase failed counter and lock account id cross threshold
  def loginFailed
    self.failed += 1
    # bypass if konfig is zero, means no fail checking
    if Konfig::KONFIGS[ :allowedFailedLogin ] != 0 && self.failed > Konfig::KONFIGS[ :allowedFailedLogin ]
      self.lock = true
    end
    self.save!
    return nil
  end

  # Clear (set to 0) failed counter on first successful login
  # Do not anything to lock, admin should unlock it
  def clearLoginFailed
    self.failed = 0
    if self.changed?
      self.save!
    end
    return self
  end

  #def self.init
  #  puts 'Initing User'
  #  User.users = Hash.new
  #  User.all.each { |u| @users[u.id] = UserCache.new( u.id, u.email, u.roles, u.rights, u.applets ) }
  #  User.users.each { |user| user.inspect }
  #end

  private
    def encrypt_password
      if !password.blank?
        self.salt = "omtv1" + make_salt # if new_record?
        self.pswd = "omtv1" + encrypt( password )
      end
    end

    def encrypt( string )
      secure_hash( "#{salt}--Omid--#{string}" )
    end

    def make_salt
      secure_hash( "#{Time.now.utc}--Omid--#{password}" )
    end

    def secure_hash( string )
      Digest::SHA2.hexdigest( string )
    end


    # User model cache update methods
  #  def upd_usr
  #    puts 'update user'
  #    @users[ self.id ] = UserCache.new( u.id, u.email, u.roles, u.rights, u.applets )
  #  end
  #
  #  def dest_usr
  #    puts 'delete user'
  #    @users.delete( self.id )
  #  end
  #
  #User.init

end
#
