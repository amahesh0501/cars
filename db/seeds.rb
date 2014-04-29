# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "amahesh0501@gmail.com", password: "12345678", site_admin: true)
User.create(email: "sal@gmail.com", password: "12345678", site_admin: false)
Dealership.create(dealership_name: "Auto1Pay", active: true)
Membership.create(user_id: 2, dealership_id: 1, is_dealership_admin: true, has_access: true)
