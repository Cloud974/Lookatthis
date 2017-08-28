require 'random_data'

50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

Post.find_or_create_by!(
  title: "This is IDEMPOTENCE",
  body: "This is the body that goes along with it"
)

Comment.find_or_create_by!(
  post: Post.find(101),
  body: "This is also IDEMPOTENCE"
)

puts "Seed Finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
