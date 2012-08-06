# encoding: utf-8
class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :show
  belongs_to :serial
  has_one :advisor, :class_name => "User", :foreign_key => "video_id"
  has_many :roles
  has_many :people, :through=>:roles
  has_many :sequences, :order=>"position", :dependent=>:destroy
  has_many :szenes, :through=>:sequences
  has_many :takes, :through=>:szenes
  has_many :media_files, :through=>:szenes
  has_many :audiotracks, :through=>:szenes
  has_many :chosen_items, :dependent => :destroy
  has_many :technical_items, :through => :chosen_items
  has_one :treatment, :dependent=>:destroy
  attr_accessible :duration, :format, :show_id, :summary, :supposed_duration, :title, :treatment_attributes, :roles, :roles_attributes, :advisor, :serial_id, :advisor_id, :chosen_items, :technical_items, :readable_duration
  
  attr_accessor :readable_duration
  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :people
  
  FORMATS=["Bericht", "Dokumentation", "Interview", "Portrait", "Reportage", "Umfrage", "Kommentar", "Clip", "Kurzfilm", "Spielfilm", "Animationsfilm", "Musikvideo", "Collage", "Experimentalfilm", "Trenner"]
  
  #after_create :build_script
  
  #define_index do
  #  indexes title
  #  indexes people.name, :as=>:person_name
  #  indexes summary
  #  indexes user
  #  indexes show
    
  #  has created_at
  #end
  
  def calculate_supposed_duration
    if readable_duration.include? ":"
      split=readable_duration.split(':', 2)
      self.supposed_duration=split.first.to_i*60+split.last.to_i
    else
      self.supposed_duration=readable_duration.to_i*60
    end
  end
  

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def build_script
    self.sequences.build(:video_id=>self.id, :name=>'Gib hier einen Titel ein').insert_at
    szene=Szene.create(:sequence_id=>self.sequences.first.id, :title=>"eindeutiger Name der Szene", :place=>"Wo spielt die Szene", :description=>"Was wird im Laufe der Szene geschehen?")
    szene.insert_at
    take=Take.create(:szene_id=>szene.id, :view_desc=>"detaillierte Beschreibung, was zu sehen ist mit Angaben für die Kamera", :audio_desc=>"genaue Beschreibung, was zu hören ist, auch Hintergrundgeräusche", :duration=>1, :note=>"Wichtige Hinweise, z.B. zum Anschluss an die nächste Aufnahme")
    take.insert_at
  end
  
  private


end
