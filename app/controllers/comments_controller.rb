class CommentsController < ApplicationController
  def index 

  end 

  def new 

  end 

  def create 
    @comment = Comment.create(post_params)
    @comment.save!
    
  end

  def post_params 
    params.require(:comment).permit(:user_id, :post_id, :body)
  end

end
