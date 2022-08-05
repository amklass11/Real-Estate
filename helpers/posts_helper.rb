# frozen_string_literal: true

module PostsHelper
  def post_thumbnail_url(post)
    post.image.present? ? post.image.thumb.url : asset_url('post_placeholder.jpg')
  end
end
