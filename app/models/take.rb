class Take < ActiveRecord::Base
  acts_as_list :scope=>:szene
  belongs_to :szene
  belongs_to :video
  belongs_to :address
  has_many :pictures
  attr_accessible :audio_desc, :duration, :note, :position, :view_desc, :szene_id, :szene, :address, :address_id, :pictures, :picture_attributes
  
  accepts_nested_attributes_for :pictures
end
