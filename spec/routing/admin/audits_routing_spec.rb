require "spec_helper"

describe Admin::AuditsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/audits").should route_to("admin/audits#index")
    end

    it "routes to #new" do
      get("/admin/audits/new").should route_to("admin/audits#new")
    end

    it "routes to #show" do
      get("/admin/audits/1").should route_to("admin/audits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/audits/1/edit").should route_to("admin/audits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/audits").should route_to("admin/audits#create")
    end

    it "routes to #update" do
      put("/admin/audits/1").should route_to("admin/audits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/audits/1").should route_to("admin/audits#destroy", :id => "1")
    end

  end
end
