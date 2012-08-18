class Character < ActiveRecord::Base
  belongs_to :treatment
  belongs_to :person
  attr_accessible :charactername, :treatment_id, :person, :person_id
  
end
