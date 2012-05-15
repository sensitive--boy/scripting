class Role < ActiveRecord::Base
  belongs_to :video_id
  attr_accessible :role, :show_id
end
