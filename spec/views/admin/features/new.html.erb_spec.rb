require 'spec_helper'

describe "admin_features/new" do
  before(:each) do
    assign(:feature, stub_model(Admin::Feature).as_new_record)
  end

  it "renders new feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_features_path, :method => "post" do
    end
  end
end
