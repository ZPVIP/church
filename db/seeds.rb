# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.new
user.email = 'adminzp@gmail.com'
user.encrypted_password = '$2a$10$lxaMEJcVU58f3iZ2SLXp9u3RPQA0qnIKEAzbsvVDYxtAH2/VlD0Uy'
user.admin = true
user.save!