class Address < ActiveRecord::Base
  belongs_to :person
  attr_accessible :addition, :address, :city, :country, :venue, :zip
end
