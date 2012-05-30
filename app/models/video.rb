class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :show
  has_many :roles
  has_many :people, :through=>:roles
  has_many :sequences
  has_many :szenes, :through=>:sequences
  has_many :takes, :through=>:szenes
  has_many :media_files, :through=>:szenes
  has_many :audiotracks, :through=>:szenes
  attr_accessible :duration, :format, :show_id, :summary, :supposed_duration, :title
end
