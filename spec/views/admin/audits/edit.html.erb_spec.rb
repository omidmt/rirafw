require 'spec_helper'

describe "admin/audits/edit" do
  before(:each) do
    @admin_audit = assign(:admin_audit, stub_model(Admin::Audit))
  end

  it "renders the edit admin_audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_audits_path(@admin_audit), :method => "post" do
    end
  end
end
