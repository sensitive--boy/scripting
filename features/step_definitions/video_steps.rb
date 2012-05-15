# encoding: utf-8

Gegebensei /^ein User "([^"]*)"$/ do |arg1|
  User.create(username: "viola") 
end

Wenn /^viola angemeldet und eingeloggt ist$/ do
  visit root_path
  click_link "Sign up now!"
  fill_in "user_email", with: "viola@example.com"
  fill_in "user_username", with: "viola"
  fill_in "user_password", with: "beispiel"
  fill_in "user_password_confirmation", with: "beispiel"
  click_button "Sign up"
  page.should have_content("data.")
  save_and_open_page
end

Wenn /^seine Personendaten eingegeben hat$/ do
  fill_in "person_firstname", with: "Viola"
  fill_in "person_name", with: "Zurück"
  fill_in "person_address_attributes_address", with: "Beispiel-Los-Straße 69"
  click_button "Update Person"
  page.should have_content("Beitrag anlegen")
end
                                                                                                                                                                                                
Dann /^soll er einen Beitrag anlegen können\.$/ do                                                                                                                                              
  pending # express the regexp above with the code you wish you had                                                                                                                             
end 