class Treatment < ActiveRecord::Base
  belongs_to :video
  has_one :main_character, :class_name => 'Character'
  has_many :characters
  has_many :people, :through=>:characters
  attr_accessible :conflict, :development, :first_szene_desc, :keywords, :main_characteristic, :moral, :place, :storyline, :text, :main_character_attributes, :person_tokens, :video_id
  
  accepts_nested_attributes_for :main_character
  accepts_nested_attributes_for :characters
  
end
