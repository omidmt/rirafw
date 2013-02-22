require 'spec_helper'

describe "admin/audits/new" do
  before(:each) do
    assign(:admin_audit, stub_model(Admin::Audit).as_new_record)
  end

  it "renders new admin_audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_audits_path, :method => "post" do
    end
  end
end
