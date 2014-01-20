class PostsController < ApplicationController
  before_action :set_blog
  before_action :set_post, only: %i[show]

  def index
    @posts = @blog.posts.page(params[:page])
  end

  def show
  end

  def preview
    render text: RDiscount.new(params[:text].to_s).to_html
  end

  private

  def set_blog
    @blog = Blog.find_by_subdomain request.subdomain
  end

  def set_post
    @post = @blog.posts.find(params[:id])
  end
end
