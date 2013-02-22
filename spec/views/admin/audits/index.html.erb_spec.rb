require 'spec_helper'

describe "admin/audits/index" do
  before(:each) do
    assign(:admin_audits, [
      stub_model(Admin::Audit),
      stub_model(Admin::Audit)
    ])
  end

  it "renders a list of admin/audits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
