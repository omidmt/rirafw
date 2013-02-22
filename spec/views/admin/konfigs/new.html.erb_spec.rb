require 'spec_helper'

describe "admin/konfigs/new" do
  before(:each) do
    assign(:admin_konfig, stub_model(Admin::Konfig).as_new_record)
  end

  it "renders new admin_konfig form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_konfigs_path, :method => "post" do
    end
  end
end
