class Character < ActiveRecord::Base
  belongs_to :treatment
  has_one :person
  attr_accessible :charactername
end
