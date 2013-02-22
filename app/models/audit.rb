class Audit < ActiveRecord::Base
  attr_accessible :datetime, :message, :origin, :user
end
