class Szene < ActiveRecord::Base
  belongs_to :sequence
  has_many :takes
  has_many :media_files
  has_many :audiotracks
  attr_accessible :description, :place, :position, :title
end
