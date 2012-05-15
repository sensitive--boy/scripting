class Person < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  has_one :address, :dependent=>:destroy
  attr_accessible :email, :firstname, :messenger, :mobile, :name, :phone, :video_id, :address_attributes
  
  #validates :name, :presence=>true
  validates :email, :presence=>{:message=>"You need to fill in at least one contact possibility"}, :unless=>lambda {self.phone.present? || self.mobile.present? || self.messenger.present?}
  
  accepts_nested_attributes_for :address
end
