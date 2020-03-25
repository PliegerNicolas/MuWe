module EmbedLinkHelper
  def embed_link(post)
    if post.references.first
      youtube_regex = %r{(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.[^\s]+}
      # soundcloud_regex = %r{(http(s)?:\/\/)?((w){3}.)?(soundcloud|snd)(\.com|\.sc)?\/.[^\s]+} SOUNDCLOUD IS AN ANOYING API
      url = post.references.first
      if url =~ youtube_regex
        youtube_id = url.split('v=')[1]
        render "posts/embeded_links/youtube", youtube_id: youtube_id
      end
    end
  end
end
