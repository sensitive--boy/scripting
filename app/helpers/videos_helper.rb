module VideosHelper
  def nice_time(seconds)
    [(seconds/60).to_s, (seconds%60).to_s].join(':')
  end
  
  def state_dependent_hint(video)
    if video.state == "proposed_idea" && current_user==video.advisor
	  "Bitte gib den Beitrag zur Bearbeitung des Treatments frei. | "
	  link_to "Freigeben", accept_idea_video_path(video)
    elsif video.state == "accepted_idea" && current_user!=video.advisor
	  "Zeit, ein Treatment auszuarbeiten!"
	  link_to "Treatment ist fertig.", fin_treat_video_path(video)
    elsif video.state == "treatment_finished" && current_user==video.advisor
	  "Bitte gib den Beitrag zur Produktion frei oder hinterlasse einen Kommentar. | "
	  link_to "Freigeben", acc_treat_video_path(video)
    elsif video.state == "accepted_treatment" && current_user!=video.advisor
	  "Erstelle ein Script und leg los mit der Produktion. | "
	  link_to "Beitrag ist fertig.", fin_prod_video_path(video)
    elsif video.state == "production_finished" && current_user==video.advisor
	  "Bitte gib den Beitrag zur Fertigstellung frei. | "
	  link_to "Freigeben", acc_prod_video_path(video)
    elsif video.state == "accepted_production" && current_user!=video.advisor
	  "Bitte stell alle Unterlagen zusammen und schreib einen Kurztext zum Beitrag. | "
	  link_to "Fertig zur Ausstrahlung", fin_vid_video_path(video)
    elsif video.state == "video_finished" && current_user==video.advisor
	  "Bitte Sendedatum bzw. Archivnummer eintragen. | "
	  link_to "Archivieren", arch_vid_video_path(video)
    else
	video.hint
    end
  end
end
