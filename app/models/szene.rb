class Szene < ActiveRecord::Base
  belongs_to :sequence
  attr_accessible :description, :place, :position, :title
end
