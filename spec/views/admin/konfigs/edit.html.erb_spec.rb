require 'spec_helper'

describe "admin/konfigs/edit" do
  before(:each) do
    @admin_konfig = assign(:admin_konfig, stub_model(Admin::Konfig))
  end

  it "renders the edit admin_konfig form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_konfigs_path(@admin_konfig), :method => "post" do
    end
  end
end
