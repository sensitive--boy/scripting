class Show < ActiveRecord::Base
  belongs_to :user
  has_one :advisor, :class_name => "User", :foreign_key => "show_id"
  has_many :videos
  attr_accessible :date, :duration, :title, :toppic, :user_attributes
  
    def self.search(search)
    if search
      where("toppic LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
end
