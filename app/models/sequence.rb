class Sequence < ActiveRecord::Base
  acts_as_list :scope => :video
  belongs_to :video
  has_many :szenes, :order=>'position', :dependent=>:destroy
  attr_accessible :name, :position, :video, :video_id
  
end
