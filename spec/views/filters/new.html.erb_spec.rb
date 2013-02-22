require 'spec_helper'

describe "filters/new" do
  before(:each) do
    assign(:filter, stub_model(Filter).as_new_record)
  end

  it "renders new filter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => filters_path, :method => "post" do
    end
  end
end
