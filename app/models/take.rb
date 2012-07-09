class Take < ActiveRecord::Base
  acts_as_list :scope=>:szene
  belongs_to :szene
  belongs_to :video
  has_one :address
  attr_accessible :audio_desc, :duration, :note, :position, :view_desc, :szene_id, :szene, :address
end
