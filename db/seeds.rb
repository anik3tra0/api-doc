# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(email: "aniket.rao@gmail.com", password: "abcd1234")
user.save


10.times do
	post = Post.new
	post.title = Faker::Book.title
	post.content = Faker::Hipster.paragraph(2, true)
	post.save
end