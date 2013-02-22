class Micropost < ActiveRecord::Base
  attr_accessible :content  #, :msisdn_id

  belongs_to :user
  #belongs_to :subscriber, :foreign_key => 'msisdn_id'

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'

end
