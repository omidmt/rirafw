require 'spec_helper'

describe "admin/rights/new" do
  before(:each) do
    assign(:admin_right, stub_model(Admin::Right).as_new_record)
  end

  it "renders new admin_right form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_rights_path, :method => "post" do
    end
  end
end
