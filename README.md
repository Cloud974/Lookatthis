# lookit: a Reddit replica.

![landing screen](/app/assets/images/landing-lookit.jpg)

Lookit is built with Rails 5.1.4 and Ruby 2.4, as an exercise in both basic Rails structures as well as test driven development (TDD) - where RSpec was utilized to create over 200 tests.

## lookit: what is visible and what is not.

The basic organization for lookit is that topics contain posts, and posts have comments. For users, there are three classes- a basic user model and an admin(or moderator). The most important element in transferring this structure into the app, was to manage who sees which elements. Some basic guidelines would be imposed.

Topics- being analogous to subreddits- needed to be something not just anyone could implement, so admins would be solely responsible there.

Posts, on the other hand, would be a little bit more involved. while the posts themselves would be visible universally- the controls for the post would be revealed only if someone was supposed to see them. Two aspects were connected. In the posts helper:

```ruby

def user_is_authorized_for_post?(post)
  current_user && (current_user == post.user || current_user.admin?)
end
```

connected to the view:

```erb

<% if user_is_authorized_for_post?(@post) %>
  <div class="col-md-4">
      <%= link_to 'Edit', edit_topic_post_path(@post.topic, @post), class: 'btn btn-success'  %>
      <%= link_to 'Delete Post', [@post.topic, @post], method: :delete, class: 'btn btn-danger',  data: {confirm: 'Are you sure you want to delete this post?'} %>
  </div>
<% end %>
```

rendering or obscuring:

![post buttons](/app/assets/images/postbuttons.jpg)

Of course, posts should be ordered by relevance, as well. so the rank  implemented in the post model works against a post's vote status-

![vote buttons](/app/assets/images/votebuttons.jpg)

 over that post's lifetime-

 ```ruby
 def update_rank
   age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
   new_rank = points + age_in_days
   update_attribute(:rank, new_rank)
 end
 ```

 leading to a list like so:

![ordered posts](/app/assets/images/topic-posts.jpg)

```ruby
def update_rank
  age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
  new_rank = points + age_in_days
  update_attribute(:rank, new_rank)
end
```
