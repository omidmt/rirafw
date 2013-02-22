require 'spec_helper'

describe "admin_features/index" do
  before(:each) do
    assign(:admin_features, [
      stub_model(Admin::Feature),
      stub_model(Admin::Feature)
    ])
  end

  it "renders a list of admin_features" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
