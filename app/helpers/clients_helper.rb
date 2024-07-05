module ClientsHelper
  def project_count_for_status(client, status)
    client.projects.where(status: status).count
   end
end
