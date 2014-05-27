# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.first.nil?
  user = User.new
else
  user = User.first
end
user.email = 'adminzp@gmail.com'
user.password = 'aaaaaaaa'
user.password_confirmation = 'aaaaaaaa'
user.name = 'Peter'
user.blocked = false
user.save!
