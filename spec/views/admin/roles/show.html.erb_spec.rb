require 'spec_helper'

describe "admin_roles/show" do
  before(:each) do
    @role = assign(:role, stub_model(Admin::Role))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
