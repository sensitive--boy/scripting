class Role < ActiveRecord::Base
  belongs_to :video
  belongs_to :person
  attr_accessible :role, :person_id, :video_id, :person
  attr_reader :person_tokens
  
  ROLES=["Kamera", "Regie", "Redaktion", "Schnitt", "Effekte", "Ton", "Beleuchtung", "Animation"]
  
    
  def person_tokens=(ids)
    self.person_ids=ids.split(",")
  end
end
