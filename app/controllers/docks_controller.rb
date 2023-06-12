class DocksController < ApplicationController
  before_action :set_dock, only: %i[ show edit update destroy ]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]


  # GET /docks or /docks.json
  def index
    @total_file = 0
    @docks = Dock.all
  end

  # GET /docks/1 or /docks/1.json
  def show
    @dock = Dock.find(params[:id])
    ActiveStorage::Current.url_options = {
      host: request.base_url,
      protocol: request.protocol
    }
  end

  # GET /docks/new
  def new
    @dock = Dock.new
  end

  # GET /docks/1/edit
  def edit
  end

  # POST /docks or /docks.json
  def create
    files = Array(params[:dock][:files])
    if files.length <= 1
      redirect_to new_dock_path, notice: "please select a file"
    else
      files.each do |file|
        next if file.blank?
        @dock = Dock.new(dock_params)
        @dock.files.attach(file)
        @dock.title = file.original_filename if file.respond_to?(:original_filename)
        @dock.format = file.content_type.to_s if file.respond_to?(:content_type)
        
        @dock.save
      end
        respond_to do |format|
          if @dock.persisted?
            format.html { redirect_to dock_url(@dock)}
            format.json { render :show, status: :created, location: @dock }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @dock.errors, status: :unprocessable_entity }
          end
        end
      end
  end

  # PATCH/PUT /docks/1 or /docks/1.json
  def update
    respond_to do |format|
      if @dock.update(dock_params)
        format.html { redirect_to dock_url(@dock)}
        format.json { render :show, status: :ok, location: @dock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docks/1 or /docks/1.json
  def destroy
    @dock.destroy

    respond_to do |format|
      format.html { redirect_to docks_url, notice: "Dock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dock
      @dock = Dock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dock_params
      params.require(:dock).permit(:title, :user_id, :format, docks: [])
    end

    def correct_user
      @dock = Dock.find(params[:id])
      if current_user.id != @dock.user_id
        redirect_to new_dock_path
      end
    end
    
end
