class CharactersController < ApplicationController
  autocomplete :person, :name, :full=>true, :extra_data=>[:id]
  
  def autocomplete_person_name
    @people = Person.find(:all, :order => 'name ASC')

    re = Regexp.new("^#{params[:character][:person_name]}", "i")
    @pers = @people.find_all do |t|
      t.name.match re
    end
  end
  
  def person_name=(name)
     person= Person.find_by_name(name)
     if person           
       self.person_id = person.id
     else              
       errors[:person_name] << "Invalid name entered"
     end               
   end
   
   def person_name       
     Person.find(person_id).name if person_id
   end   
end
