require 'spec_helper'

describe "filters/show" do
  before(:each) do
    @filter = assign(:filter, stub_model(Filter))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
