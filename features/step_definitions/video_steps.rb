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
end

Wenn /^seine Personendaten eingegeben hat$/ do
  fill_in "person_name", with: "Viola Zurück"
  fill_in "person_address_attributes_address", with: "Beispiel-Los-Straße 69"
  click_button "Update Person"
  page.should have_link("Beitrag anlegen")
end
                                                                                                                                                                                                
Dann /^soll er einen Beitrag anlegen können\.$/ do                                                                                                                                              
  click_link "Beitrag anlegen"
  fill_in "video_title", with: "violas video"
  fill_in "video_format", with: "test"
  fill_in "video_supposed_duration", with: 132
  fill_in "video_summary", with: "Das ist der Testbeitrag aus meinem ersten Cucumber Feature-Test."
  click_button "Create Video"
  page.should have_content "angelegtes Video"
end 





Gegebensei /^ein anderer User "([^"]*)"$/ do |arg1|
  User.create(username: "kerstin") 
end

Wenn /^kerstin angemeldet und eingeloggt ist$/ do
  visit root_path
  click_link "Sign up now!"
  fill_in "user_email", with: "kerstin@example.com"
  fill_in "user_username", with: "kerstin"
  fill_in "user_password", with: "example"
  fill_in "user_password_confirmation", with: "example"
  click_button "Sign up"
  page.should have_content("data.")
  fill_in "person_name", with: "Kerstin Vorwärts"
  fill_in "person_address_attributes_address", with: "Beispiel-Haft-Straße 42"
  click_button "Update Person"
  page.should have_link("Beitrag anlegen")
  click_link "Sign out"
end

Wenn /^kerstin die Eigenschaft advisor hat$/ do
  visit root_path
  click_link "Administrate"
  fill_in "admin_login", with: "admin"
  fill_in "admin_password", with: "scripting"
  click_button "Sign in"
  page.should have_link("administrate users")
  save_and_open_page
  click_link "administrate users"
  page.should have_content("Administrate Users")
  page.should have_link("Make me advisor!")
  click_link "Make me advisor!"
  page.should have_content("I am Advisor.")
  click_link "Sign out"
  click_link "Sign_in"
  fill_in "user_login", with: "kerstin"
  fill_in "user_password", with: "example"
  page.should have_link("Sendung anlegen")
end

Dann /^soll er eine Sendung anlegen können\.$/ do
  click_link "Sendung anlegen"
  fill_in "show_date", with: " "
  fill_in "show_title", with: "Heute im TV"
  fill_in "show_toppic", with: "großartiges Beispiel"
  fill_in "show_duration", with: 1243
  click_button "Create Show"
  page.should have_content("Heute im TV")
end
