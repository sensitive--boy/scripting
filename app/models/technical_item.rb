class TechnicalItem < ActiveRecord::Base
  has_many :chosen_items, :dependent => :destroy
  has_many :videos, :through => :chosen_items
  mount_uploader :manual, ManualUploader
  attr_accessible :available, :date_of_purchase, :description, :identifier, :manual, :name, :remove_manual, :videos, :chosen_items
  
  def become_chosen
    self.chosen=true
    save!
    puts "chosen should be true now"
   puts chosen?
  end
  
  def discard
    self.chosen=false
    save!
    puts "chosen should be false now"
    puts chosen?
  end
end
