class PostsController < ApplicationController
  before_action :select_post, only: [:show,:edit,:update,:vote]
  before_action :require_user, except: [:index,:show, :vote]
  before_action :require_user_to_vote, only: [:vote]

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
    @vote = Vote.create(voteable: @post, vote: params[:vote], user: current_user)

    respond_to do |format|
      format.html {redirect_to :back, notice: "Your vote was recorded"}
      format.js
    end
  
  end


  private 
  def post_params
    params.require(:post).permit!
  end

  def select_post
    @post = Post.find_by(slug: params[:id])
  end
end
