class RF
  attr_accessor :name, :description, :code, :hash, :stat, :expiry, :max_user

  def initialize( name, desc, code, stat, hash, expiry, max_user )
    self.name = name
    self.code = code
    self.description = desc
    self.stat = stat
    self.hash = hash
    self.max_user = max_user
    if /^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$/.match expiry
      self.expiry = Date.strptime( expiry )
    else
      self.expiry = expiry
    end
  end

  #def isValid?
  #  if !self.hash == Digest::SHA2.hexdigest( "#{self.name } #{self.stat} #{self.code} #{self.expiry} #{self.max_user}" )
  #    return false
  #  end
  #  if !isActive?
  #    return false
  #  end
  #
  #  return true
  #end
  #
  #def isActive?
  #  if self.expiry == "no expiry"
  #    return true
  #  else
  #    Date.today < self.expiry
  #  end
  #end

  eval "#{AESHelper.prepare "cPiv+mz8JxNijVGYARl95Q==$NLFPGWl1lMStVqc3xNFTLU2peTclOxqezQ2NpODJg3fSY9VuqqGNVSc/mYcT\nweQVMGrEySyxO56CECY+mbqXmKQdLkbpYv0InvEdnGk6CQv84uKJBeyVsmqw\ngIoD4nI32xZcqFsoZmDKttq+tPK5gVIo/zcv0m8p4TAUEW35AQHqLr8cVD5K\nfcaUIG4/mkXR9QWsAOn1Od8LtLtlpBNDulsvZKKHh7b19QXkD0pwaRRP1Hgs\nJMDonSYE68gvVnmzQ4es1SjcpmKrU5oUxpxksLJ0lItPNBw69mWpHEF7fC0u\nbSYi5TygrEvLzXBWSA5Fq8bRDF8IoclVeqi+9iiLCBFdB/K0BdShCw/TDJ2O\nH6JjG7i9im+ry2oFo8/DWWwbUmdriQxVFS0YCjuHfUoWFfNmV+wTK+mn3A8Z\n1vwj7vArXleNHdzG2L8X08V5uluZW5NtvdQ1FAiUfzj3M+2xFESmtLuVsyoK\nFrqGIfZx06M=" }"

  def hash
    Digest::SHA2.hexdigest( "#{self.name } #{self.stat} #{self.code} #{self.expiry} #{self.max_user}" )
  end

end

