require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "sould have the right title" do
      get 'home'
      response.body.should have_selector("title", :content => "Scripting | Home")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
        
    it "sould have the right title" do
      get 'contact'
      response.body.should have_selector("title", :content => "Scripting | Contact")
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
        
    it "sould have the right title" do
      get 'about'
      response.body.should have_selector("title", :content => "Scripting | About")
    end
  end

end
