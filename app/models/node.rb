class Node < ActiveRecord::Base
  extend Util

  attr_accessible :ip, :name, :pass, :pass_confirmation, :pass2, :pass2_confirmation, :pass3, :pass3_confirmation,
                  :port, :user, :user2, :user3, :active, :serverModel, :klass, :port2, :port3

  #validates :pass, :presence => true, :on => :create,
  #          :confirmation => true

  #class << self; attr_accessor :default_airs, :default_vss, :default_crss,
  #                             :default_ccn_voice, :default_ccn_sms, :default_ccn_gprs,
  #                             :default_ccn_others
  #end

  after_save :reload
  after_destroy :reload

  def pass
    begin
      AESHelper.decrypt read_attribute( :pass )
    rescue => err
      Util::Applog.error "node=#{self.name} pass read accessor exception[#{err}]"
      read_attribute( :pass )
    end
  end

  def pass=( password )
    if !password.nil? && password != ''
      write_attribute( :pass, AESHelper.encrypt( password ))
    else
      write_attribute( :pass, '' )
    end
  end

  def pass2
    begin
      AESHelper.decrypt read_attribute( :pass2 )
    rescue => err
      Util::Applog.error "node=#{self.name} pass2 read accessor exception[#{err}]"
      read_attribute( :pass2 )
    end
  end

  def pass2=( password )
    if !password.nil? && password != ''
      write_attribute( :pass2, AESHelper.encrypt( password ))
    else
      write_attribute( :pass2, '' )
    end
  end

  def pass3
    begin
      AESHelper.decrypt read_attribute( :pass3 )
    rescue => err
      Util::Applog.error "node=#{self.name} pass3 read accessor exception[#{err}]"
      read_attribute( :pass3 )
    end
  end

  def pass3=( password )
    if !password.nil? && password != ''
      write_attribute( :pass3, AESHelper.encrypt( password ))
    else
      write_attribute( :pass3, '' )
    end
  end

  def pass4
    begin
      AESHelper.decrypt read_attribute( :pass4 )
    rescue => err
      Util::Applog.error "node=#{self.name} pass4 read accessor exception[#{err}]"
      read_attribute( :pass4 )
    end
  end

  def pass4=( password )
    if !password.nil? && password != ''
      write_attribute( :pass4, AESHelper.encrypt( password ))
    else
      write_attribute( :pass4, '' )
    end
  end

  validates :pass, :presence => true, :if => Proc.new { |node| !node.pass.blank? },
            :confirmation => true

  validates :pass2, :presence => true, :if => Proc.new { |node| !node.pass2.blank? },
            :confirmation => true

  validates :pass3, :presence => true, :if => Proc.new { |node| !node.pass3.blank? },
            :confirmation => true

  validates :pass4, :presence => true, :if => Proc.new { |node| !node.pass4.blank? },
            :confirmation => true

  validates :port, :numericality => {:only_integer => true, :greater_than => 0, :allow_nil => true }
  validates :port2, :numericality => {:only_integer => true, :greater_than => 0, :allow_nil => true }
  validates :port3, :numericality => {:only_integer => true, :greater_than => 0, :allow_nil => true }
  validates :port4, :numericality => {:only_integer => true, :greater_than => 0, :allow_nil => true }

  def self.init_actives

    if Konfig::KONFIGS[ :debug ]
      Util::Applog.info "Initializing active nodes"
    end

    #@default_airs = Node.where( ['klass like :type and `default` = :default', {:type => '%AIR%', :default => TRUE }] )
    #@default_vss = Node.where( ['klass like :type and `default` = :default', {:type => '%VS%', :default => TRUE }] )
    #@default_crss = Node.where( ['klass like :type and `default` = :default', {:type => '%CRS%', :default => TRUE }] )
    #@default_ccn_voice = [] # Node.where( ['klass like :type and `default` = :default', {:type => '%CCN%', :default => TRUE }] )
    #@default_ccn_sms = []
    #@default_ccn_gprs = []
    #@default_ccn_others = []

    # Reconfging dependent models

  end

  Node.init_actives

  private

    def reload
      Node.init_actives
    end

end