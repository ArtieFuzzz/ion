class E621Controller < ApplicationController
  before_action :authorized, only: [:index]

  def index
    tags = params[:tags]
    limit = params[:limit]

    if !tags || !limit 
      render json: {message: 'Missing parameters!'}
      return
    end

    posts = fetch(tags, limit)

    render json: posts
  end

  private

  def fetch(tags, limit)
    resp = HTTP.get('https://e621.net/posts.json', :params => { tags: 'limit:#{limit} order:random -young #{tags}' })

    resp.to_s
  end
end
