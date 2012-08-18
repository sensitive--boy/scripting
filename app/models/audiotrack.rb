class Audiotrack < ActiveRecord::Base
  belongs_to :szene
  attr_accessible :album, :fraction_length, :interpreter, :title, :szene_id
end
