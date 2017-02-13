class ResidentsController < ApplicationController
  before_action :set_resident, only: [:show, :edit, :update, :destroy, :sign_in]

  # GET /residents
  # GET /residents.json
  def index
    @residents = Resident.all
  end

  # GET /residents/1
  # GET /residents/1.json
  def show
  end

  # GET /residents/new
  def new
    @resident = Resident.new
  end

  # GET /residents/1/edit
  def edit
  end

  # POST /residents
  # POST /residents.json
  def create
    @resident = Resident.new(resident_params)

    respond_to do |format|
      if @resident.save
        format.html { redirect_to @resident, notice: 'Resident was successfully created.' }
        format.json { render :show, status: :created, location: @resident }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /residents/1
  # PATCH/PUT /residents/1.json
  def update
    respond_to do |format|
      if @resident.update(resident_params)
        format.html { redirect_to @resident, notice: 'Resident was successfully updated.' }
        format.json { render :show, status: :ok, location: @resident }
      else
        format.html { render :edit }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  def subscribe
    @resident = Resident.find_by(id: cookies.signed[:resident_id])
    @resident.subscription_endpoint = resident_subscription_params[:endpoint]
    @resident.subscription_keys_p256dh = resident_subscription_params[:keys][:p256dh]
    @resident.subscription_keys_auth = resident_subscription_params[:keys][:auth]

    respond_to do |format|
      if @resident.save
        format.html { redirect_to @resident, notice: 'Resident subscription was successfully created.' }
        format.json { render :show, status: :created, location: @resident }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /residents/1
  # DELETE /residents/1.json
  def destroy
    @resident.destroy
    respond_to do |format|
      format.html { redirect_to residents_url, notice: 'Resident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sign_in
    cookies.signed[:resident_id] = @resident.id

    redirect_to @resident, notice: 'You have been logged in as this resident'
  end

  def geolocation
    puts params
    @resident = Resident.find_by(id: cookies.signed[:resident_id])
    @resident.latitude = resident_geolocation_params[:latitude]
    @resident.longitude = resident_geolocation_params[:longitude]

    respond_to do |format|
      if @resident.save
        format.html { redirect_to @resident, notice: 'Resident geolocation was successfully updated.' }
        format.json { render :show, status: :geolocated, location: @resident }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resident
      @resident = Resident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resident_params
      params.require(:resident).permit(:email, :first_name, :last_name, :zip_code, :last_known_zip_code)
    end

    def resident_subscription_params
      params.require(:resident).permit(:endpoint, keys: [:p256dh, :auth])
    end

    def resident_geolocation_params
      params.require(:resident).permit(:latitude, :longitude)
    end
end
