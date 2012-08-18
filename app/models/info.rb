class Info < ActiveRecord::Base
  belongs_to :szene
  attr_accessible :addition, :function, :name, :szene_id
end
