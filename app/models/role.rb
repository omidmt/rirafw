class Role < ActiveRecord::Base
  attr_accessible :description, :name, :right_ids
  #attr_accessor :right_ids

  has_many :permissions, :dependent => :destroy
  has_many :user_roles, :dependent => :destroy
  has_many :users, :through => :user_roles
  has_many :rights, :through =>  :permissions

end
