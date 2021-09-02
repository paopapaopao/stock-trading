# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin user
User.create!(
  first_name: "admin",
  last_name: "admin",
  email: "admin@example.com",
  password: "password",
  isadmin: true,
  status: "approved",
  confirmed_at: Date.new,
)
User.create!(
  first_name: "malakas",
  last_name: "",
  email: "malakas@example.com",
  password: "password",
  isadmin: false,
  status: "approved",
  confirmed_at: Date.new,
  role_id: 1
)
User.create!(
  first_name: "maganda",
  last_name: "",
  email: "maganda@example.com",
  password: "password",
  isadmin: false,
  status: "approved",
  confirmed_at: Date.new,
  role_id: 2
)

Role.create!(
  name: 'broker',
  user_id: 1
)
Role.create!(
  name: 'buyer',
  user_id: 2
)
