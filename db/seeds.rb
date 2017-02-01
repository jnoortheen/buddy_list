# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# number of user records
NR_REC = 10
# creating user records
NR_REC.times do
  User.create(full_name: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password)
end

# create friendship
0.upto(NR_REC) do |n|
  user = User.all[n]
  choice = (0...NR_REC).to_a
  choice.delete(n)
  # add any of the two users as friends
  user.add_friend User.all[choice.sample]
  user.add_friend User.all[choice.sample]
end
