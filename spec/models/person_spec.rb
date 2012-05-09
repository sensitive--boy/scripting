require 'spec_helper'

describe Person do
  
  before (:each) do
    @attr = {:name=>"Beispiel", :email=>"beispiel@beispiel.net", :phone=>"123123", :mobile=>"987987", :messenger=>"beispiel@jabber.ccc.com"}
  end
  
  it "should create a new instance given valid attributes" do
    Person.create!(@attr)
  end
  
  it "should require a name" do
    no_name_person = Person.new(@attr.merge(:name=>""))
    no_name_person.should_not be_valid
  end
  
  it "should require at least one contact possibility" do
    no_contact_person = Person.new(@attr.merge(:phone=>"", :mobile=>"", :email=>"", :messenger=>""))
    no_contact_person.should_not be_valid
  end
  
  it "should be valid with just one contact" do
    messenger_person = Person.new(@attr.merge(:phone=>"", :mobile=>"", :email=>""))
    messenger_person.should be_valid
  end
 end
