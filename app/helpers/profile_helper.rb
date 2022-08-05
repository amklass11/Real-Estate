# frozen_string_literal: true

module ProfileHelper
  def cover_image_url(account)
    account.cover_image.present? ? account.cover_image.url : asset_url('cover_placeholder.gif')
  end
end
