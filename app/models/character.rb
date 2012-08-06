class Character < ActiveRecord::Base
  belongs_to :treatment
  belongs_to :person
  attr_accessible :charactername, :person_name, :treatment_id, :person, :person_id
  
  def person_name
     person.name if person_id
   end
end
