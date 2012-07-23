class Picture < ActiveRecord::Base
  belongs_to :take
  attr_accessible :description, :image, :position, :take_id
  mount_uploader :image, ImageUploader
end
