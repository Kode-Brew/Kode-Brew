# db/seeds.rb

# Exclui todos os registros existentes
Ticket.delete_all
Task.delete_all
SprintLecture.delete_all
Sprint.delete_all
Lecture.delete_all
ProjectMember.delete_all
Project.delete_all
Client.delete_all
User.delete_all

# Criando Clients
clients = [
  { category: 'Tecnologia', name: 'Tech Innovators Inc.', address: '123 Tech Lane', email: 'contact@techinnovators.com', cell_phone: '555-1234' },
  { category: 'Saúde', name: 'Healthcare Solutions Ltd.', address: '456 Health Blvd', email: 'info@healthsolutions.com', cell_phone: '555-5678' }
]
clients.each { |client| Client.create!(client) }

# Criando Users
users = [
  { email: 'john@example.com', password: 'password123', password_confirmation: 'password123', name: 'John Smith', role: 'TA', points: '0' },
  { email: 'jane@example.com', password: 'password123', password_confirmation: 'password123', name: 'Jane Smith', role: 'Teacher', points: '37' }
]
users.each { |user| User.create!(user) }

# Criando Projects
projects = [
  { client_id: Client.first.id, name: 'Project Alpha', category: 'Desenvolvimento de Software', description: 'Desenvolvimento de um novo sistema.', is_active?: true },
  { client_id: Client.last.id, name: 'Project Beta', category: 'Pesquisa Médica', description: 'Pesquisa sobre novas terapias.', is_active?: true }
]
projects.each { |project| Project.create!(project) }

# Criando Project Members
project_members = [
  { user_id: User.first.id, project_id: Project.first.id, user_type: 1 },
  { user_id: User.last.id, project_id: Project.last.id, user_type: 2 }
]
project_members.each { |project_member| ProjectMember.create!(project_member) }

# Criando Sprints
sprints = [
  { project_id: Project.first.id, date_start: '2024-01-01', date_end: '2024-01-15', objective: 'Sprint 1 do Project Alpha' },
  { project_id: Project.last.id, date_start: '2024-02-01', date_end: '2024-02-15', objective: 'Sprint 1 do Project Beta' }
]
sprints.each { |sprint| Sprint.create!(sprint) }

# Criando Tasks
tasks = [
  { name: 'Setup Environment', priority: 'Alta', description: 'Configuração do ambiente de desenvolvimento', status: 'Aberto', points: 3, user_id: User.first.id, sprint_id: Sprint.first.id },
  { name: 'Research Topic A', priority: 'Média', description: 'Pesquisa sobre o tópico A', status: 'Em Progresso', points: 5, user_id: User.last.id, sprint_id: Sprint.last.id }
]
tasks.each { |task| Task.create!(task) }

# Criando Tickets
tickets = [
  { status: 'Aberto', user_id: User.first.id, task_id: Task.first.id },
  { status: 'Fechado', user_id: User.last.id, task_id: Task.last.id }
]
tickets.each { |ticket| Ticket.create!(ticket) }

# Criando Lectures
lectures = [
  { title: 'Introdução ao Rails', source: 'YouTube', video: 'link_do_video', slide: 'link_dos_slides' },
  { title: 'Avançado em Rails', source: 'Vimeo', video: 'link_do_video', slide: 'link_dos_slides' }
]
lectures.each { |lecture| Lecture.create!(lecture) }

# Criando Sprint Lectures
sprint_lectures = [
  { sprint_id: Sprint.first.id, lecture_id: Lecture.first.id, project_member_id: ProjectMember.first.id },
  { sprint_id: Sprint.last.id, lecture_id: Lecture.last.id, project_member_id: ProjectMember.last.id }
]
sprint_lectures.each { |sprint_lecture| SprintLecture.create!(sprint_lecture) }

puts "Database seeded successfully."
