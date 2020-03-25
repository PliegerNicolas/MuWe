class PostsController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @post = Post.new(post_params)
    @post.user_id = @profile.user.id
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
    set_post
    authorize @post
  end

  def update
    set_post
    if params[:post][:description]
      authorize @post
      @post.update!(description: params[:post][:description])
    end
    redirect_to profile_path(@profile.id)
  end

  def destroy
    set_post
    authorize @post
    if @post.valid?
      respond_to do |format|
        format.html { redirect_to profile_path(@profile.id) }
        format.js
      end
      @post.destroy
    else
      respond_to do |format|
        format.html { render 'profiles/profile' }
        format.js
      end
    end
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

  def set_post
    @post = Post.find(params[:id])
    @profile = Profile.find(params[:profile_id])
  end
end
