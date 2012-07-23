class Address < ActiveRecord::Base
  belongs_to :person
  has_many :takes
  attr_accessible :addition, :address, :city, :country, :venue, :zip, :takes
  
  def find_for_input
    Address.find(:all, :conditions => ['lower(venue) like ? or lower(address) like ? or lower(city) like ?', '%'+params[:address][:take].downcase + '%', '%'+params[:address][:take].downcase + '%', '%'+params[:address][:take].downcase + '%' ])
  end
end
