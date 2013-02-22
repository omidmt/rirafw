require 'spec_helper'

describe "admin_roles/edit" do
  before(:each) do
    @role = assign(:role, stub_model(Admin::Role))
  end

  it "renders the edit role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_roles_path(@role), :method => "post" do
    end
  end
end
