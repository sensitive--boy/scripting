class AutocompleteController < ApplicationController
   def people
     if params[:term]
       like  = "%".concat(params[:term].concat("%"))
       people = Person.where("name like ?", like)
     else
       people = Person.all
     end
     list = people.map {|u| Hash[id: u.id, label: u.name, name: u.name]}
     render json: list            
   end
end
