class PostsController < ApplicationController
  before_action :select_post, only: [:show,:edit,:update]

  def index
    @posts = Post.all
  end

  def show

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash["notice"] = "Your post was successfully created"
      redirect_to posts_path
    else
      render :new
    end

  end

  def edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash["notice"] = "Your post was successfully updated"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def post_params
    params.require(:post).permit!
  end

  def select_post
    @post = Post.find(params[:id])
  end
end
