class CommentsController < ApplicationController
  before_action :select_comment, only: [:vote]
  before_action :require_user, except: [:vote]
  before_action :require_user_to_vote, only: [:vote]
  before_action :require_creator, only: [:edit,:update]

  def new
    @comment = Comment.new
  end


  def create
    @post = Post.find_by(slug: params[:post_id])
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
    @vote = Vote.create(voteable: @comment, vote: params[:vote], user: current_user)

    respond_to do |format|
      format.html {redirect_to :back, notice: "Your vote was recorded"}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def select_comment
    @comment = Comment.find(params[:id])
  end

    # check if current user created post or comment
  def require_creator
    deny_access unless logged_in? && current_user.is_creator?(@comment)
  end
end