class Sequence < ActiveRecord::Base
  belongs_to :video
  has_many :szenes
  attr_accessible :name, :position
end
