# encoding: utf-8
class Video < ActiveRecord::Base
  include ActiveModel::Transitions
  belongs_to :user
  belongs_to :show
  belongs_to :serial
  belongs_to :advisor, :class_name => "User"
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
  attr_accessible :duration, :format, :show_id, :summary, :supposed_duration, :title, :treatment_attributes, :roles, :roles_attributes, :advisor, :serial_id, :advisor_id, :chosen_items, :technical_items, :readable_duration, :comments
  
  attr_accessor :readable_duration
  
  FORMATS=["Bericht", "Dokumentation", "Interview", "Portrait", "Reportage", "Umfrage", "Kommentar", "Clip", "Kurzfilm", "Spielfilm", "Animationsfilm", "Musikvideo", "Collage", "Experimentalfilm", "Trenner"]
  
  

  
  state_machine do
    state :created #initial state
    state :proposed_idea
    state :accepted_idea
    state :treatment_finished
    state :accepted_treatment
    state :production_finished
    state :accepted_production
    state :video_finished
    state :archivated
    
    event :propose do
      transitions :to => :proposed_idea, :from => :created, :on_transition => :propose_idea
    end
    event :accept_idea do
      transitions :to => :accepted_idea, :from => :proposed_idea, :on_transition => :do_accept_idea
    end
    event :finish_treatment do
      transitions :to => :treatment_finished, :from => :accepted_idea, :on_transition => :do_finish_treatment
    end
    event :accept_treatment do
      transitions :to => :accepted_treatment, :from => :treatment_finished, :on_transition => :do_accept_treatment
    end
    event :finish_production do
      transitions :to => :production_finished, :from => :accepted_treatment, :on_transition => :do_finish_production
    end
    event :accept_production do
      transitions :to => :accepted_production, :from => :production_finished, :on_transition => :do_accept_production
    end
    event :finish_video do
      transitions :to => :video_finished, :from => :accepted_production, :on_transition => :do_finish_video
    end
    event :archivate do
      transitions :to => :archivated, :from => :video_finished, :on_transition => :do_archivate
    end
  end
  
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
    self.hint="Bitte wähle einen Betreuer für Dein Videoprojekt"
    self.sequences.build(:video_id=>self.id, :name=>'Gib hier einen Titel ein').insert_at
    szene=Szene.create(:sequence_id=>self.sequences.first.id, :title=>"eindeutiger Name der Szene", :place=>"Wo spielt die Szene", :description=>"Was wird im Laufe der Szene geschehen?")
    szene.insert_at
    take=Take.create(:szene_id=>szene.id, :view_desc=>"detaillierte Beschreibung, was zu sehen ist mit Angaben für die Kamera", :audio_desc=>"genaue Beschreibung, was zu hören ist, auch Hintergrundgeräusche", :duration=>1, :note=>"Wichtige Hinweise, z.B. zum Anschluss an die nächste Aufnahme")
    take.insert_at
  end
  
  private
    def propose_idea
      self.hint="Bitte warte mit der Bearbeitung des Treatments auf die Freigabe."
    end
    
    def do_accept_idea
      self.hint="Das Treatment befindet sich in der Bearbeitung."
    end
    
    def do_finish_treatment
      self.hint="Bitte warte auf die Freigabe, bevor Du anfängst zu drehen."
    end
    
    def do_accept_treatment
      self.hint="Der Beitrag befindet sich in der Produktion."
    end
    
    def do_finish_production
      self.hint="Bitte warte auf eine Rückmeldung zu Deinem Beitrag."
    end
    
    def do_accept_production
      self.hint="Dokumente und Kurztext werden erstellt."
    end
    
    def do_finish_video
      self.hint="Dein Beitrag kann jetzt gesendet werden."
    end
    
    def do_archivate
      self.hint="Beitrag ist archiviert."
    end

end
