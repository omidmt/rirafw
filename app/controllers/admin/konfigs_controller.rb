class Admin::KonfigsController < Backend::SecureController
  # GET /admin/konfigs
  # GET /admin/konfigs.json
  def index
    @konfigs = Konfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @konfigs }
    end
  end

  # GET /admin/konfigs/1
  # GET /admin/konfigs/1.json
  def show
    @konfig = Konfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @konfig }
    end
  end

  # GET /admin/konfigs/new
  # GET /admin/konfigs/new.json
  def new
    @konfig = Konfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @konfig }
    end
  end

  # GET /admin/konfigs/1/edit
  def edit
    @konfig = Konfig.find(params[:id])
  end

  # POST /admin/konfigs
  # POST /admin/konfigs.json
  def create
    @konfig = Konfig.new(params[:konfig])

    respond_to do |format|
      if @konfig.save
        format.html { redirect_to admin_konfig_path(@konfig), notice: 'Config was successfully created.' }
        format.json { render json: @konfig, status: :created, location: @konfig }
      else
        format.html { render action: "new" }
        format.json { render json: @konfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/konfigs/1
  # PUT /admin/konfigs/1.json
  def update
    @konfig = Konfig.find(params[:id])

    respond_to do |format|
      if @konfig.update_attributes(params[:konfig])
        format.html { redirect_to admin_konfig_path(@konfig), notice: 'Config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @konfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/konfigs/1
  # DELETE /admin/konfigs/1.json
  def destroy
    @konfig = Konfig.find(params[:id])
    @konfig.destroy

    respond_to do |format|
      format.html { redirect_to admin_konfigs_url }
      format.json { head :no_content }
    end
  end
end
