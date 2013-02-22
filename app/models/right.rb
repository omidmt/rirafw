class Right < ActiveRecord::Base

  RIGHT_ALLOW_POLICY = 0
  RIGHT_DENY_POLICY = 1

  attr_accessible :action, :controller, :policy, :applet_ids
  #attr_accessor :applet_id

  has_many :permissions, :dependent => :destroy
  has_one :right_applet, :dependent => :destroy
  has_many :applets, :through => :right_applet

  #def applet_id
  #  nil
  #end

end
