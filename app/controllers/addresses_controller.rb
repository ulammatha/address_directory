class AddressesController < ApplicationController
  before_action :authenticate_user!, only:[:index, :show, :new,:create, :edit, :update, :destroy]
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @addresses = current_user.addresses.all
  end

  def show
  end

  def new
    @address = current_user.addresses.build
  end

  def edit
  end

  def create
    @address = current_user.addresses.build(address_params)

    if @address.save
      flash[:success] = 'Address was successfully added.'
    end
    respond_with @address, location: addresses_path

    # respond_to do |format|
    #   if @address.save
    #     format.html { redirect_to @address, notice: }
    #     format.json { render :show, status: :created, location: @address }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @address.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    if @address.update(address_params)
      flash[:success] = 'Address was successfully updated.'
    end
    respond_with @address, location: addresses_path
    # respond_to do |format|
    #   if @address.update(address_params)
    #     format.html { redirect_to @address, notice: '' }
    #     format.json { render :show, status: :ok, location: @address }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @address.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    @address.destroy
    flash[:notice] = 'Address was successfully destroyed.'
    respond_with @address
    # respond_to do |format|
    #   format.html { redirect_to addresses_url, notice: '' }
    #   format.json { head :no_content }
    # end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.
        require(:address).
        permit(
          :first_name,
          :last_name,
          :appartment_number,
          :street,
          :city,
          :state,
          :zip_code,
          :phone_number
        )
    end
end
