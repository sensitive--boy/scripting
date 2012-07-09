# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

###
$(document).ready ->
  $('#character_person_id').autocomplete
    source: "/autocomplete/people"
    select: (event,ui) -> $("#character_person_id").val(ui.item.id)
###