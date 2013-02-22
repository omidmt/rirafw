class Admin::RightsController < Backend::SecureController

  # GET /admin/rights
  # GET /admin/rights.json
  def index
    @title = "Access Rights"
    @rights = Right.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rights }
    end
  end

  # GET /admin/rights/1
  # GET /admin/rights/1.json
  def show
    @right = Right.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @right }
    end
  end

  # GET /admin/rights/new
  # GET /admin/rights/new.json
  def new
    @right = Right.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @right }
    end
  end

  # GET /admin/rights/1/edit
  def edit
    @right = Right.find(params[:id])
    puts @right.inspect
  end

  # POST /admin/rights
  # POST /admin/rights.json
  def create
    @right = Right.new(params[:right])

    respond_to do |format|
      if @right.save
        format.html { redirect_to admin_right_path(@right), notice: 'Right was successfully created.' }
        format.json { render json: @right, status: :created, location: @right }
      else
        format.html { render action: "new" }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/rights/1
  # PUT /admin/rights/1.json
  def update
    @right = Right.find(params[:id])

    respond_to do |format|
      if @right.update_attributes(params[:right])
        format.html { redirect_to admin_right_path(@right), notice: 'Right was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/rights/1
  # DELETE /admin/rights/1.json
  def destroy
    @right = Right.find(params[:id])
    @right.destroy

    respond_to do |format|
      format.html { redirect_to admin_rights_url }
      format.json { head :no_content }
    end
  end
end
