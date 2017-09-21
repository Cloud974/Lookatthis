module UsersHelper

  def no_posts?(user)
    @posts = user.posts.count

    if @posts == 0
      true
    else
      false
    end
  end

  def no_comments?(user)
    @comments = user.comments.count

    if @comments == 0
      true
    else
      false
    end
  end

  def no_favorites?(user)
    @favorites = user.favorites.count

    if @favorites == 0
      true
    else
      false
    end
  end


end
