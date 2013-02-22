class RightApplet < ActiveRecord::Base
  attr_accessible :applet_id, :right_id

  belongs_to :right
  belongs_to :applet
  #has_one :applet
end