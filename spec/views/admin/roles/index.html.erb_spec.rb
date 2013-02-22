require 'spec_helper'

describe "admin_roles/index" do
  before(:each) do
    assign(:admin_roles, [
      stub_model(Admin::Role),
      stub_model(Admin::Role)
    ])
  end

  it "renders a list of admin_roles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
