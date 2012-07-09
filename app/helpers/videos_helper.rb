module VideosHelper
  def video_link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def video_link_to_add_person(name, f)
    fields = f.fields_for(:roles, Role.new, :child_index => "new_role") do |builder|
      render("people_fields", :f => builder)
    end
    link_to_function(name, "add_people_fields(this, \"#{escape_javascript(fields)}\")")
  end
end
