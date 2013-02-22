require 'spec_helper'

describe "admin_features/show" do
  before(:each) do
    @feature = assign(:feature, stub_model(Admin::Feature))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
