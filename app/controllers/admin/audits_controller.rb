class Admin::AuditsController < Backend::SecureController
  # GET /admin/audits
  # GET /admin/audits.json
  def index
    @audits = Audit.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audits }
    end
  end

  # GET /admin/audits/1
  # GET /admin/audits/1.json
  def show
    @audit = Audit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audit }
    end
  end

  # GET /admin/audits/new
  # GET /admin/audits/new.json
  def new_disabled
    @audit = Audit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audit }
    end
  end

  # GET /admin/audits/1/edit
  def edit_disabled
    @audit = Audit.find(params[:id])
  end

  # POST /admin/audits
  # POST /admin/audits.json
  def create_disabled
    @admin_audit = Audit.new(params[:admin_audit])

    respond_to do |format|
      if @admin_audit.save
        format.html { redirect_to @admin_audit, notice: 'Audit was successfully created.' }
        format.json { render json: @admin_audit, status: :created, location: @admin_audit }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/audits/1
  # PUT /admin/audits/1.json
  def update_disabled
    @admin_audit = Audit.find(params[:id])

    respond_to do |format|
      if @admin_audit.update_attributes(params[:admin_audit])
        format.html { redirect_to @admin_audit, notice: 'Audit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/audits/1
  # DELETE /admin/audits/1.json
  def destroy_disabled
    @admin_audit = Audit.find(params[:id])
    @admin_audit.destroy

    respond_to do |format|
      format.html { redirect_to admin_audits_url }
      format.json { head :no_content }
    end
  end
end
