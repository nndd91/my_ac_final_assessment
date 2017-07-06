# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Note.destroy_all

email = "demo@demo.com"
password = "password"
username = "demo"
firstname = "demo"
lastname = "demo"

@user = User.create(email: email, password: password, username: username, firstname: firstname, lastname: lastname)

10.times do
  content = Faker::HarryPotter.quote
  @note = @user.notes.build(content: content)
  @note.save
end

10.times do
  email = Faker::Internet.email
  password = "password"
  username = Faker::Internet.user_name
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name

  @user = User.create(email: email, password: password, username: username, firstname: firstname, lastname: lastname)

  10.times do
    content = Faker::HarryPotter.quote
    @note = @user.notes.build(content: content)
    @note.save
  end

  10.times do
    offset = rand(User.count)
    user2 = User.offset(offset).limit(1).first
    @user.follow(user2)
  end

  10.times do
    offset = rand(Note.count)
    note = Note.offset(offset).limit(1).first
    @user.like(note)
  end
end
