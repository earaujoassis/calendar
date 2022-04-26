# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.create(name: "New Year's Day", day: 1, month: 1)
Event.create(name: 'Halloween', day: 31, month: 10)
Event.create(name: 'Christmas', day: 25, month: 12)
