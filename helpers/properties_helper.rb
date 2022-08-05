# frozen_string_literal: true

module PropertiesHelper
  def property_thumbnail(property)
    img = property.photo.present? ? property.photo.thumb.url : 'placeholder.jpg'
    image_tag img, class: 'property-thumb'
  end

  def property_thumbnail_url(property)
    property.photo.present? ? property.photo.thumb.url : asset_url('placeholder.jpg')
  end

  def property_photo_url(property)
    property.photo.present? ? property.photo.url : asset_url('placeholder.jpg')
  end
end
