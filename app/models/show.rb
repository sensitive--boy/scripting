class Show < ActiveRecord::Base
  belongs_to :user
  belongs_to :serial
  has_one :advisor, :class_name => "User", :foreign_key => "show_id"
  has_many :videos
  attr_accessible :date, :duration, :title, :toppic, :user_attributes, :serial, :moderation, :short_text, :serial_id
  
    def self.search(search)
    if search
      where("toppic LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
end
