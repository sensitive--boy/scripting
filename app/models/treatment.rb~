class Treatment < ActiveRecord::Base
  belongs_to :video
  has_one :main_character, :class_name => 'Character'
  has_many :characters
  attr_accessible :conflict, :development, :first_szene_desc, :keywords, :main_characteristc, :moral, :place, :storyline, :text
end
