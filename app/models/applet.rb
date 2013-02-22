class Applet < ActiveRecord::Base
  attr_accessible :description, :icon, :name, :path

  ALL_APPLETS = Applet.all

  has_one :right_applet, :dependent => :destroy
  #belongs_to :right_applet

end
