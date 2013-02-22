require "spec_helper"

describe Admin::KonfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/konfigs").should route_to("admin/konfigs#index")
    end

    it "routes to #new" do
      get("/admin/konfigs/new").should route_to("admin/konfigs#new")
    end

    it "routes to #show" do
      get("/admin/konfigs/1").should route_to("admin/konfigs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/konfigs/1/edit").should route_to("admin/konfigs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/konfigs").should route_to("admin/konfigs#create")
    end

    it "routes to #update" do
      put("/admin/konfigs/1").should route_to("admin/konfigs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/konfigs/1").should route_to("admin/konfigs#destroy", :id => "1")
    end

  end
end
