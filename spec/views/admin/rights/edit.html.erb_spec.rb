require 'spec_helper'

describe "admin/rights/edit" do
  before(:each) do
    @admin_right = assign(:admin_right, stub_model(Admin::Right))
  end

  it "renders the edit admin_right form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_rights_path(@admin_right), :method => "post" do
    end
  end
end
