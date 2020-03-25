module EmbedLinkHelper
  def embed_link(post)
    if post.references.first
      youtube_regex = %r{(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.[^\s]+}
      soundcloud_regex = %r{(http(s)?:\/\/)?((w){3}.)?(soundcloud|snd)(\.com|\.sc)?\/.[^\s]+}
      url = post.references.first
      if url =~ youtube_regex
        youtube_id = url.split('v=')[1]
        render "posts/embeded_links/youtube", youtube_id: youtube_id
      elsif url =~ soundcloud_regex
        raise
        soundcloud_id = "a"
        render "posts/embeded_links/soundcloud", soundcloud_id: soundcloud_id
      end
    end
  end
end
