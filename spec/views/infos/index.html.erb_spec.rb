require 'spec_helper'

describe "infos/index" do
  before(:each) do
    assign(:infos, [
      stub_model(Info,
        :name => "Name",
        :function => "Function",
        :addition => "Addition",
        :szene => nil
      ),
      stub_model(Info,
        :name => "Name",
        :function => "Function",
        :addition => "Addition",
        :szene => nil
      )
    ])
  end

  it "renders a list of infos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Function".to_s, :count => 2
    assert_select "tr>td", :text => "Addition".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
