require 'spec_helper'

describe "infos/show" do
  before(:each) do
    @info = assign(:info, stub_model(Info,
      :name => "Name",
      :function => "Function",
      :addition => "Addition",
      :szene => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Function/)
    rendered.should match(/Addition/)
    rendered.should match(//)
  end
end
