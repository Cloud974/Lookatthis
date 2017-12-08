require 'faker'
require 'random_data'

20.times do
   User.create!(
   name:     Faker::RickAndMorty.character,
   email:    Faker::Internet.unique.email,
   password: Faker::Internet.password
   )
 end
 users = User.all

15.times do
  Topic.create!(
    name:    Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph(2, false, 0)
  )
end
topics = Topic.all

50.times do
    post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(2, false, 4),
  )

  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end

posts = Post.all

200.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: Faker::Lorem.paragraph(3, false, 4)
  )
end

admin = User.create!(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )

 member = User.create!(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
