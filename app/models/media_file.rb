class MediaFile < ActiveRecord::Base
  belongs_to :szene
  attr_accessible :description, :origin, :szene_id, :free_to_use
end
