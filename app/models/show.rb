class Show < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  attr_accessible :date, :duration, :title, :toppic, :user_attributes
end
