class TicketController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]

  # Displays a list of tickets
  def index
    @tickets = Ticket.all
  end

  # Displays details of a specific ticket
  def show
  end

  # Renders form to create a new ticket
  def new
    @ticket = Ticket.new
  end

  # Creates a new ticket
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user
    @ticket.task = Task.first
    if @ticket.save
      flash[:alert] = "Ticket criado com sucesso."

      redirect_to tickets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Renders form to edit a ticket
  def edit
  end

  # Updates a ticket
  def update
    if @ticket.update(ticket_params)
      flash[:alert] = "ticket editado  com sucesso."

      redirect_to tickets_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes a ticket
  def destroy
    @ticket.destroy!
    redirect_to tickets_path
  end

  private

  # Permits ticket parameters
  def ticket_params
    params.require(:ticket).permit(:status)
  end

  # Sets the ticket instance variable based on the provided id
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
