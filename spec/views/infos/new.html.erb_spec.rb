require 'spec_helper'

describe "infos/new" do
  before(:each) do
    assign(:info, stub_model(Info,
      :name => "MyString",
      :function => "MyString",
      :addition => "MyString",
      :szene => nil
    ).as_new_record)
  end

  it "renders new info form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => infos_path, :method => "post" do
      assert_select "input#info_name", :name => "info[name]"
      assert_select "input#info_function", :name => "info[function]"
      assert_select "input#info_addition", :name => "info[addition]"
      assert_select "input#info_szene", :name => "info[szene]"
    end
  end
end
