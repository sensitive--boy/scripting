module VideosHelper
  def nice_time(seconds)
    [(seconds/60).to_s, (seconds%60).to_s].join(':')
  end
  
  #def state_dependent_hint(video)
  #  html = ''
   # if video.state == "proposed_idea"
#	  html <<  'Bitte gib den Beitrag zur Bearbeitung des Treatments frei. | '
#	  html << link_to "Freigeben", acc_idea_video_path(video)
   # elsif video.state == "accepted_idea"
#	  html << 'Zeit, ein Treatment auszuarbeiten! | '
#	  html << link_to "Treatment ist fertig.", fin_treat_video_path(video)
 #   elsif video.state == "treatment_finished"
#	  html << 'Bitte gib den Beitrag zur Produktion frei oder hinterlasse einen Kommentar. | '
#	  html << link_to "Freigeben", acc_treat_video_path(video)
 #   elsif video.state == "accepted_treatment"
#	  html << 'Erstelle ein Script und leg los mit der Produktion. | '
#	  html << link_to "Beitrag ist fertig.", fin_prod_video_path(video)
 #   elsif video.state == "production_finished"
#	  html << 'Bitte gib den Beitrag zur Fertigstellung frei. | '
#	  html << link_to "Freigeben", acc_prod_video_path(video)
  #  elsif video.state == "accepted_production"
#	  html << 'Bitte stell alle Unterlagen zusammen und schreib einen Kurztext zum Beitrag. | '
#	  html << link_to "Fertig zur Ausstrahlung", fin_vid_video_path(video) 
 #   elsif video.state == "video_finished"
#	  html << 'Bitte Sendedatum bzw. Archivnummer eintragen. | '
#	  html << link_to "Archivieren", arch_vid_video_path(video)
 #   else
#	html << video.hint
 #   end
 #   return html.html_safe
 # end
end
