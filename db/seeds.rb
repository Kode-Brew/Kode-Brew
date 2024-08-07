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
  { category: 'Tecnologia', name: 'Tech Innovators Inc.', address: '123 Tech Lane', email: 'contact@techinnovators.com', cell_phone: '1155512344' },
  { category: 'Saúde', name: 'Healthcare Solutions Ltd.', address: '456 Health Blvd', email: 'info@healthsolutions.com', cell_phone: '1155556788' }
]
clients.each { |client| Client.create!(client) }

# Criando Users
users = [
  { email: 'john@example.com', password: 'password123', password_confirmation: 'password123', name: 'John Smith', role: 'TA', points: '0' },
  { email: 'jane@example.com', password: 'password123', password_confirmation: 'password123', name: 'Jane Smith', role: 'Teacher', points: '37' },
  { email: 'karina@example.com', password: 'password123', password_confirmation: 'password123', name: 'Karina Smith', role: 'TA', points: '0', is_admin: 'true' }

]
users.each { |user| User.create!(user) }

# Criando Projects
projects = [
  { client_id: Client.first.id, name: 'Project Alpha', category: 'Desenvolvimento de Software', description: 'Desenvolvimento de um novo sistema.', is_active: true, active_sprint: 1 },
  { client_id: Client.last.id, name: 'Project Beta', category: 'Pesquisa Médica', description: 'Pesquisa sobre novas terapias.', is_active: true, active_sprint: 4 }
]
projects.each { |project| Project.create!(project) }

# Criando Sprints
sprints = [
  { project_id: Project.first.id, date_start: '2024-01-01', date_end: '2024-01-18', objective: 'Sprint 1 do Project Alpha' },
  { project_id: Project.first.id, date_start: '2024-02-07', date_end: '2024-01-15', objective: 'Criar histórias usuários' },
  { project_id: Project.last.id, date_start: '2024-02-01', date_end: '2024-02-15', objective: 'Sprint 1 do Project Beta' }
]
sprints.each { |sprint| Sprint.create!(sprint) }

# Criando Tasks
tasks = [
  { name: 'Setup Environment', priority: 'Alta', description: 'Configuração do ambiente de desenvolvimento', status: 'Aberto', points: 3, user_id: User.first.id, sprint_id: Sprint.first.id },
  { name: 'CRUD de Projects', priority: 'Alta', description: 'Realizar o CRUD de Projetos', status: 'Finalizado', points: 8, user_id: User.first.id, sprint_id: Sprint.first.id },
  { name: 'Research Topic A', priority: 'Média', description: 'Pesquisa sobre o tópico A', status: 'Em Progresso', points: 5, user_id: User.last.id, sprint_id: Sprint.last.id }
]
tasks.each { |task| Task.create!(task) }

puts "Database seeded successfully."
