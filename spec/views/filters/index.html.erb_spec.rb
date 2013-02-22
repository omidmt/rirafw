require 'spec_helper'

describe "filters/index" do
  before(:each) do
    assign(:filters, [
      stub_model(Filter),
      stub_model(Filter)
    ])
  end

  it "renders a list of filters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
