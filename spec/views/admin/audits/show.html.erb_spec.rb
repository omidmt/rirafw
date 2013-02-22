require 'spec_helper'

describe "admin/audits/show" do
  before(:each) do
    @admin_audit = assign(:admin_audit, stub_model(Admin::Audit))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
