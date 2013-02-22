require 'spec_helper'

describe "admin_features/edit" do
  before(:each) do
    @feature = assign(:feature, stub_model(Admin::Feature))
  end

  it "renders the edit feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_features_path(@feature), :method => "post" do
    end
  end
end
