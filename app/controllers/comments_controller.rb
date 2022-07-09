class CommentsController < ApplicationController
  def index 

  end 

  def new 

  end 

  def upvote
    @opposite_liking = get_opposite_comment_liking(current_user, CommentLiking.new(liking_params)).first

    @opposite_liking.destroy if @opposite_liking

    @already_liked = CommentLiking.where(liking_params)

    if @already_liked.empty?
      @liking = CommentLiking.create(liking_params)  
    else 
      @already_liked.first.destroy
    end

    respond_to do |format| 
      format.html { redirect_to "#{root_path}#upvote-count-#{params[:id]}" }
      format.js {  }
    end
  end

  def create 
    @comment = Comment.new(comment_params)
    @comment.save!
    redirect_to post_path(@comment.post_id)
  end

  def reply 
    respond_to do |format| 
      format.html { redirect_back fallback_location: root_path }
      format.js { }    
    end
  end

  def show_replies 
    @children_ids = []
    @comment = Comment.find(params[:comment_id])
    @post_id = @comment.post_id

    @comment.children.each { |reply| @children_ids.append(reply.id) }

    respond_to do |format| 
      format.html { redirect_back fallback_location: root_path }
      format.js {  }  
    end
  end

  def comment_params 
    params.require(:comment).permit(:user_id, :post_id, :body, :parent_id)
  end

  def liking_params 
    params.require(:liking).permit(:user_id, :comment_id, :is_upvote)
  end

end
