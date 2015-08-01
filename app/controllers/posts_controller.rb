class PostsController < ApplicationController
  before_action :select_post, only: [:show,:edit]

  def index
    @posts = Post.all
  end

  def show

  end

  def new
    @posts = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Your post was successfully created"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def post_params
    params.require(:post).permit!
  end

  def select_post
    @posts = Post.find(params[:id])
  end
end
