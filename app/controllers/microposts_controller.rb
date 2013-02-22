class MicropostsController < Backend::SecureController

  # POST /microposts
  # POST /microposts.json
  def create
    begin
    @micropost = current_user.microposts.build(params[:micropost])

    if @micropost.save
      flash[:success] = "Micropost created!"
      flash[:error] = 'Error'
      #redirect_to home_path
    else
      #render home_path
      flash[:error] = 'Error'
    end

    rescue => err
      flash[:error] = err
    end

    redirect_to home2_path, :error => 'Error'

    #respond_to do |format|
    #  if @micropost.save
    #    format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
    #    format.json { render json: @micropost, status: :created, location: @micropost }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @micropost.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy

    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.json { head :no_content }
    end
  end
end
