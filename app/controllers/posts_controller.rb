class PostsController < ApplicationController
  def create
    @profile = Profile.find(current_user.id)
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    add_links_to_references(@post.description)
    authorize @post
    if @post.save
      respond_to do |format|
        format.html { redirect_to profile_path(@profile.id) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'profiles/profile' }
        format.js
      end
    end
  end

  def edit
    find_post
    raise
  end

  def destroy
    find_post
    @post.destroy
    raise
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :description, :references)
  end

  def add_links_to_references(text)
    youtube_regex = %r{(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.[^\s]+}
    soundcloud_regex = %r{(http(s)?:\/\/)?((w){3}.)?(soundcloud|snd)(\.com|\.sc)?\/.[^\s]+}
    regexes = [youtube_regex, soundcloud_regex]
    regexes.each do |regex|
      @post.references << text.match(regex)[0] if text.match(regex)
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
