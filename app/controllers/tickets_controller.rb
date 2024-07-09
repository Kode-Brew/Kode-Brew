class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]
  before_action :set_breadcrumbs, except: %i[ mytickets update destroy]

  # Displays a list of tickets
  def index
    # @tickets = Ticket.all
    @tickets = Ticket.joins(task: { sprint: :project })
                     .where(projects: { id: current_user.projects.ids })
                     .where(status: 'Em Aberto')
  end

  def mytickets
    add_breadcrumb "Meus Tickets", mytickets_path
    if params[:filter].present?
      @tickets = current_user.tickets.where(status: 'Finalizado')
    else
      @tickets = current_user.tickets.where(status: 'Em Andamento')
    end
  end

  # Displays details of a specific ticket
  def show
    add_breadcrumb @ticket.id, ticket_path(@ticket)
  end

  # Renders form to create a new ticket
  def new
    add_breadcrumb "Novo Ticket", new_ticket_path
    @ticket = Ticket.new
  end

  # Creates a new ticket
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.task = Task.find(params[:ticket][:task])
    if @ticket.save
      flash[:notice] = "Ticket criado com sucesso."

      redirect_to tickets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Renders form to edit a ticket
  def edit
    add_breadcrumb @ticket.id, ticket_path(@ticket)
    add_breadcrumb "Editar Ticket", edit_ticket_path
  end

  # Updates a ticket
  def update
    update_status
    raise
    if @ticket.update(ticket_params)
      flash[:notice] = "ticket editado  com sucesso."

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

  def set_breadcrumbs
    add_breadcrumb "Tickets", tickets_path
  end

  # Permits ticket parameters
  def ticket_params
    params.require(:ticket).permit(:status, :category, :description)
  end

  # Sets the ticket instance variable based on the provided id
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def update_status
    case params[:status]
    when "0"
      @ticket.status = "Em Andamento"
    when "1"
      @ticket.status = "Finalizado"
    end
  end
end
