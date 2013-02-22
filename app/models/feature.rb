require 'digest'
require 'rf'

class Feature < ActiveRecord::Base
  attr_accessible :code, :description, :hsh, :name, :stat, :expiry, :max_user

  class << self; attr_accessor :features end

  after_save :reload
  after_destroy :reload

  def reload
    Feature.reconfigure
  end

  RF_ENABLE  = 1
  RF_DISABLE = 2

  #def self.isFeatureActive?( feat )
  #  if @features[feat] && @features[feat].stat == RF_ENABLE && @features[feat].isValid?
  #    return true
  #  else
  #    return false
  #  end
  #end

  def self.activate( name, desc, code, expiry, max_user, hash )
    rf = RF.new( name, desc, code, RF_ENABLE, hash, expiry, max_user )
    if rf.isValid?
      f = Feature.new :name => name, :description => desc, :code => code, :stat => RF_ENABLE, :hsh => hash, :expiry => expiry, :max_user => max_user
      if f.save
        reconfigure
      end
    end
  end

  def self.reconfigure
    @features = Hash.new
    Applog.info "Reloading Features"
    #puts "Reloading Features"
    Feature.all.each { |k| @features[ k.code ] = RF.new( k.name, k.description, k.code, k.stat, k.hsh, k.expiry, k.max_user ) }
  end

  def self.init
    #eval "#{AESHelper.prepare "LnorR3pPFa+JjliIBlWLzw==$GHqIXgbLYkAkaLxDKFTTn40Yzi43wGJjwE8t1yfdKbWgZHK0gQx62FYzyrqo\nDK0Tvb+FiuVh5mVUkxyVhkAPZBZ6H9dknuQ5kKK+bzAo2x1osUDVWdzk3g1V\n530tPlvjq+93GhmicRQhWK8gTlugN4deyFfkcxkj+LTGWYqsxIRhwmuKtopT\n4jQYxtXw9GTZN6s0NE7v9XiVvBoY7THWaZobtGuU+KJSdJ9x4AOBX2esXfoS\nX2ByxJ4rxa8gWF3x"}"
    eval "#{AESHelper.prepare "B4sPoIFIuxRd880zmvdy9g==$Zca/fZH3RHfqo/CV4U0n3L/vOXl+0yb3dpaL39iPHln5sC7KL7gsTSsw7bhn\nMC6A5kuof/2015vDyEgn41OwH+FuAwYlAQbEufT8HZa3XK+K1he//79VvgeB\naJDHKdH1D0kNGh5A4O/nEUruzodvMz2kvqrqikR4uMBU0UmjBckPd+A4SVrl\nXi3KYMMS985FwT87fsQPWh9x3jPjoSaSoLMVTfxamO+j8tXX1KZp9/w="}"
    self.reconfigure
  end

  Feature.init

end
