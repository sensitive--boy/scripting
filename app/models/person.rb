class Person < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  attr_accessible :email, :firstname, :messenger, :mobile, :name, :phone, :video_id
  
  validates :name, :presence=>true
  validates :email, :presence=>{:message=>"You need to fill in at least one contact possibility"}, :unless=>lambda {self.phone.present? || self.mobile.present? || self.messenger.present?}
end
