class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :show
  has_many :roles
  has_many :people, :through=>:roles
  has_many :sequences, :order=>"position", :dependent=>:destroy
  has_many :szenes, :through=>:sequences
  has_many :takes, :through=>:szenes
  has_many :media_files, :through=>:szenes
  has_many :audiotracks, :through=>:szenes
  has_one :treatment, :dependent=>:destroy
  attr_accessible :duration, :format, :show_id, :summary, :supposed_duration, :title, :treatment_attributes, :roles, :roles_attributes
  
  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :people
  
  FORMATS=["Dokumentation", "Interview", "Reportage", "Kurzfilm", "Spielfilm", "Animationsfilm", "Musikclip", "Experimentalfilm"]
  
  #after_create :build_script
  
  #define_index do
  #  indexes title
  #  indexes people.name, :as=>:person_name
  #  indexes summary
  #  indexes user
  #  indexes show
    
  #  has created_at
  #end
  
  

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


  
  private
  #def build_script
   # seq=Sequence.create(:video_id=>self.id, :name=>'Sequence 1')
    #seq.insert_at
    #szene=Szene.create(:sequence_id=>seq.id, :title=>'Example Szene', :place=>"Am Flussufer, zwischen grossen Baeumen", :description=>"Person sitzt am Ufer, schaut in den Fluss und kaut einen Grashalm.")
    #szene.insert_at
    #take=Take.create(:szene_id=>szene.id, :view_desc=>"Totale, Flussufer mit hohen Baeumen", :audio_desc=>"Vogelzwischern, Wasserrauschen, Blaetterrascheln", :duration=>3000, :note=>"Person befindet sich bereits im Bild, ist jedoch kaum zu sehen.")
    #take.insert_at
  #end

end
