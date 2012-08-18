require 'spec_helper'

describe "infos/edit" do
  before(:each) do
    @info = assign(:info, stub_model(Info,
      :name => "MyString",
      :function => "MyString",
      :addition => "MyString",
      :szene => nil
    ))
  end

  it "renders the edit info form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => infos_path(@info), :method => "post" do
      assert_select "input#info_name", :name => "info[name]"
      assert_select "input#info_function", :name => "info[function]"
      assert_select "input#info_addition", :name => "info[addition]"
      assert_select "input#info_szene", :name => "info[szene]"
    end
  end
end
