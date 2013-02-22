require 'spec_helper'

describe "admin/konfigs/index" do
  before(:each) do
    assign(:admin_konfigs, [
      stub_model(Admin::Konfig),
      stub_model(Admin::Konfig)
    ])
  end

  it "renders a list of admin/konfigs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
