class PostsController < ApplicationController
  before_action :select_post, only: [:show,:edit,:update,:vote]
  before_action :require_user, except: [:index,:show]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

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
    if @post.update(post_params)
      flash["notice"] = "Your post was successfully updated"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    vote = Vote.create(voteable: @post, vote: params[:vote], user: current_user)

    if vote.save
      flash["notice"] = "Your vote was recorded"
    end

    redirect_to :back
  end


  private 
  def post_params
    params.require(:post).permit!
  end

  def select_post
    @post = Post.find(params[:id])
  end
end
