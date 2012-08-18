class Szene < ActiveRecord::Base
  acts_as_list :scope => :sequence
  belongs_to :sequence
  has_many :takes, :order=>'position', :dependent=>:destroy
  has_many :media_files, :dependent => :destroy
  has_many :audiotracks, :dependent => :destroy
  has_many :infos, :dependent => :destroy
  attr_accessible :description, :place, :position, :title, :sequence_id, :props, :infos
end
