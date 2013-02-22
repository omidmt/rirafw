require "spec_helper"

describe Admin::RightsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/rights").should route_to("admin/rights#index")
    end

    it "routes to #new" do
      get("/admin/rights/new").should route_to("admin/rights#new")
    end

    it "routes to #show" do
      get("/admin/rights/1").should route_to("admin/rights#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/rights/1/edit").should route_to("admin/rights#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/rights").should route_to("admin/rights#create")
    end

    it "routes to #update" do
      put("/admin/rights/1").should route_to("admin/rights#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/rights/1").should route_to("admin/rights#destroy", :id => "1")
    end

  end
end
