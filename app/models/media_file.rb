class MediaFile < ActiveRecord::Base
  belongs_to :szene
  attr_accessible :description, :origin
end
