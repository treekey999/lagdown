class HomeController < ApplicationController
before_action :set_user, only: [:about]

  def index
  end


# 0508 edit
  def about
    @blogs = @user.blogs
    @recent = Post.where(blog_id: @blogs.map{|b| b.id}).order(created_at: :desc).limit(15)
   
    @photo = current_user.avatar
    OAuthCredential.where(user_id: current_user.id,provider: current_user.photo_provider).each do |p|
      @photo = p.auth_hash["info"]["image"].gsub('http://','https://')+ "?width=250&height=250&type=square"
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @blog = Blog.find_by(subdomain: request.subdomain)
        if @blog
          @user = @blog.user
        else
          @user = current_user
        end
    end

end
