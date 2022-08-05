json.extract! post, :id, :title, :url, :summary, :body, :image, :active, :created_at, :updated_at
json.url post_url(post, format: :json)
