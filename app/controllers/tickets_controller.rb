class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]
  before_action :set_breadcrumbs, except: %i[mytickets update destroy]

  # Displays a list of tickets
  def index
    # @tickets = Ticket.all
    @tickets = Ticket.joins(task: { sprint: :project })
                     .where(projects: { id: current_user.projects.ids })
                     .where(status: 'Em Aberto')
                     .where.not(tasks: { user_id: current_user.id })
  end

  def mytickets
    add_breadcrumb "Meus Tickets", mytickets_path
    # if params[:filter].present?
    case params[:filter]
    when "0"
      @tickets = current_user.student_tickets.order(status: :asc)
    when "1"
      @tickets = current_user.teacher_tickets.where(status: 'Finalizado')
    else
      @tickets = current_user.teacher_tickets.where(status: 'Em Andamento')
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
    @ticket.status = "Em Aberto"
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
    @ticket.user = current_user if params[:ticket][:status] == "Em Andamento"
    if @ticket.update(ticket_params)
      redirect_to mytickets_path
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
end
