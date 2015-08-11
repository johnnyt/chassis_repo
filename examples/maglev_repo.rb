require_relative '../lib/chassis'

Maglev.abort

ROOT_KEY = :chassis_example
Maglev[ROOT_KEY] = {}
Maglev.commit

Chassis.repo.register :maglev, Chassis::MaglevRepo.new(Maglev[ROOT_KEY])
Chassis.repo.use :maglev

class Post
  attr_accessor :id, :title, :text
end
Post.maglev_persistable

repo = Chassis.repo

puts repo.empty? Post #=> true

post = Post.new
post.title = 'Such Repos'
post.text = 'Very wow. Much design.'

repo.save post

puts post.id #=> 1

found_post = repo.find Post, post.id
found_post == post #=> true (no difference between objects in memory)

post.title = 'Such updates'
post.text = 'Very easy. Wow'

repo.save post

repo.find(Post, post.id).text #=> 'Very easy. Wow.'

class PostRepo
  extend Chassis::Repo::Delegation
end

post = Post.new
post.title = 'Such Repos'
post.text = 'Very wow. Much design.'

PostRepo.save post

post = PostRepo.find post.id
post.text #=> 'Very Easy. Wow'

PostRepo.all #=> [post]
# etc

PostRepo.delete post
PostRepo.empty? #=> true
