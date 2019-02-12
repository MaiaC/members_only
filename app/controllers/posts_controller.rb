class PostsController < ApplicationController
  before_action :require_login, except: [:index]
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save

    redirect_to posts_path
  end

  private
    def require_login
      unless logged_in?
        redirect_to login_path
      end
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
