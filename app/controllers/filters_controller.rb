class FiltersController < Backend::SecureController
  # GET /filters
  # GET /filters.json
  def index
    @filters = Filter.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @filters }
    end
  end

  # GET /filters/1
  # GET /filters/1.json
  def show
    @filter = Filter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @filter }
    end
  end

  # GET /filters/new
  # GET /filters/new.json
  def new
    @filter = Filter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @filter }
    end
  end

  # GET /filters/1/edit
  def edit
    @filter = Filter.find(params[:id])
  end

  # POST /filters
  # POST /filters.json
  def create
    @filter = Filter.find_or_create_by_name( params[:filter][:name], :group => params[:filter][:group], :pattern => params[:filter][:pattern] )

    Auditlog( self.class.name, @filter )

    respond_to do |format|
      if @filter
        format.html { redirect_to @filter, notice: 'Filter was successfully created.' }
        format.json { render json: @filter, status: :created, location: @filter }
      else
        format.html { render action: "new" }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /filters/1
  # PUT /filters/1.json
  def update
    @filter = Filter.find(params[:id])

    Auditlog( self.class.name, @filter )

    respond_to do |format|
      if @filter.update_attributes(params[:filter])
        format.html { redirect_to @filter, notice: 'Filter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filters/1
  # DELETE /filters/1.json
  def destroy
    if params[:id] != '-1'
      @filter = Filter.find(params[:id])
    else
      @filter = Filter.where( :name => params[:filter][:name], :group => params[:filter][:group], :pattern => params[:filter][:pattern] ).first
    end

    Auditlog( self.class.name, @filter )

    if @filter
      @filter.destroy
    end

    respond_to do |format|
      format.html { redirect_to filters_url }
      format.json { head :no_content }
    end
  end
end
