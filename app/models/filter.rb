class Filter < ActiveRecord::Base
  attr_accessible :group, :name, :pattern
end
