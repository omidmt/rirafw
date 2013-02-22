require "spec_helper"

describe Admin::RolesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin_roles").should route_to("admin_roles#index")
    end

    it "routes to #new" do
      get("/admin_roles/new").should route_to("admin_roles#new")
    end

    it "routes to #show" do
      get("/admin_roles/1").should route_to("admin_roles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin_roles/1/edit").should route_to("admin_roles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin_roles").should route_to("admin_roles#create")
    end

    it "routes to #update" do
      put("/admin_roles/1").should route_to("admin_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin_roles/1").should route_to("admin_roles#destroy", :id => "1")
    end

  end
end
