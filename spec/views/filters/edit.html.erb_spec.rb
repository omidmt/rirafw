require 'spec_helper'

describe "filters/edit" do
  before(:each) do
    @filter = assign(:filter, stub_model(Filter))
  end

  it "renders the edit filter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => filters_path(@filter), :method => "post" do
    end
  end
end
