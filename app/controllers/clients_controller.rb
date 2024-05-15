class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]
  def index
    @clients = Client.all
  end

  def show
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @client.update(client_params)
    redirect_to client_path(@client)
  end

  def destroy
    @client.destroy
    redirect_to client_path, status: :see_other
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(
      :category, :name, :address, :email, :cell_phone
    )
  end
end
