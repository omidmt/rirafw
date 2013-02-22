class Admin::FeaturesController < Backend::SecureController
  # GET /admin/features
  # GET /admin/features.json
  def index
    @title = "Features"
    @admin_features = Feature.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_features }
    end
  end

  # GET /admin/features/1
  # GET /admin/features/1.json
  def show
    @admin_feature = Feature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_feature }
    end
  end

  # GET /admin/features/new
  # GET /admin/features/new.json
  def new
    @admin_feature = Feature.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_feature }
    end
  end

  # GET /admin/features/1/edit
  def edit_disable
    #@admin_feature = Feature.find(params[:id])
  end

  # POST /admin/features
  # POST /admin/features.json
  def create
    @admin_feature = Feature.new(params[:feature])

    respond_to do |format|
      if @admin_feature.save
        format.html { redirect_to admin_feature_path( @admin_feature ), notice: 'Feature was successfully created.' }
        format.json { render json: @admin_feature, status: :created, location: @admin_feature }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def enable
    id = params[:id]
    f = Feature.find_by_id( id )
    if f
      f.stat = Feature::RF_ENABLE
      f.save
    end
    redirect_to admin_features_path
  end

  def disable
    id = params[:id]
    f = Feature.find_by_id( id )
    if f
      f.stat = Feature::RF_DISABLE
      f.save
    end
    redirect_to admin_features_path
  end

  def refresh
    Feature.reconfigure
    redirect_to admin_features_path
  end

  # PUT /admin/features/1
  # PUT /admin/features/1.json
  def update_disable
    #@admin_feature = Feature.find(params[:id])
    #
    #respond_to do |format|
    #  if @admin_feature.update_attributes(params[:admin_feature])
    #    format.html { redirect_to @admin_feature, notice: 'Feature was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @admin_feature.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /admin/features/1
  # DELETE /admin/features/1.json
  def destroy
    @admin_feature = Feature.find(params[:id])
    @admin_feature.destroy

    respond_to do |format|
      format.html { redirect_to admin_features_url }
      format.json { head :no_content }
    end
  end
end
