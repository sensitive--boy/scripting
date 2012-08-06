class ChosenItem < ActiveRecord::Base
  belongs_to :technical_item
  belongs_to :video
  attr_accessible :technical_item_id, :video_id
end
