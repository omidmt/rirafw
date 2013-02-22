require 'spec_helper'

describe "admin/rights/show" do
  before(:each) do
    @admin_right = assign(:admin_right, stub_model(Admin::Right))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
