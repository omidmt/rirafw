require 'spec_helper'

describe "admin/konfigs/show" do
  before(:each) do
    @admin_konfig = assign(:admin_konfig, stub_model(Admin::Konfig))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
