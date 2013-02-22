require "spec_helper"

describe Admin::FeaturesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin_features").should route_to("admin_features#index")
    end

    it "routes to #new" do
      get("/admin_features/new").should route_to("admin_features#new")
    end

    it "routes to #show" do
      get("/admin_features/1").should route_to("admin_features#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin_features/1/edit").should route_to("admin_features#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin_features").should route_to("admin_features#create")
    end

    it "routes to #update" do
      put("/admin_features/1").should route_to("admin_features#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin_features/1").should route_to("admin_features#destroy", :id => "1")
    end

  end
end
