class Permission < ActiveRecord::Base
  attr_accessible :policy, :right_id, :role_id

  belongs_to :role
  belongs_to :right

end
