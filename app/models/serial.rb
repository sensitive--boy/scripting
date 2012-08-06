class Serial < ActiveRecord::Base
  has_many :videos
  has_many :shows
  attr_accessible :description, :title, :for_shows, :videos, :shows, :video_id, :show_id
end
