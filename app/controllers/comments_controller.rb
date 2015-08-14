class CommentsController < ApplicationController
  before_action :require_user
  
  def new
    @comment = Comment.new
  end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash["notice"] = "comment was successfully created"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.create(voteable: @comment, vote: params[:vote], user: current_user)

    if vote.save
      flash["notice"] = "Your vote was recorded"
    end

    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end



  





end