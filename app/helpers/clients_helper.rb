module ClientsHelper
  def ongoing_projects_count(client)
    client.projects.where(status: [:Pendente, :Iniciado], is_active?: true).count
  end

  def finished_projects_count(client)
    client.projects.where(status: :Finalizado).count
  end

  def inactive_projects_count(client)
    client.projects.where(is_active?: false).count
  end
end
