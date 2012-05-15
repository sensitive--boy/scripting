class Take < ActiveRecord::Base
  belongs_to :szene
  attr_accessible :audio_desc, :duration, :note, :position, :view_desc
end
