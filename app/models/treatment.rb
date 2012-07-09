class Treatment < ActiveRecord::Base
  belongs_to :video
  has_one :main_character, :class_name => 'Character'
  has_many :characters
  has_many :people, :through=>:characters
  attr_accessible :conflict, :development, :first_szene_desc, :keywords, :main_characteristic, :moral, :place, :storyline, :text, :main_character, :person_tokens, :video_id
  attr_reader :person_tokens
  
  def person_tokens=(ids)
    self.person_ids=ids.split(",")
  end
end
