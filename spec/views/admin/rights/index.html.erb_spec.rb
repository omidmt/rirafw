require 'spec_helper'

describe "admin/rights/index" do
  before(:each) do
    assign(:admin_rights, [
      stub_model(Admin::Right),
      stub_model(Admin::Right)
    ])
  end

  it "renders a list of admin/rights" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
