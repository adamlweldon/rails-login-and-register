class CommentsController < ApplicationController
  def new
    #get the specific product id first; this part is what the simple form connected to
    @user=User.find(params[:user_id])
    @comment = Comment.new
  end

  def create
   
    @add_comment = User.find(params[:user_id]).comments.new(comment_param)
    
    @add_comment.commenter_id = current_user.id
    @add_comment.save
    #render :text => params #for debugging
    if @add_comment.save
      redirect_to user_path(params[:user_id]), notice: 'Comment was successfully created.'
    else
      render action: "new"
    end
  end 

  def destroy
    @destroy_comment = Comment.find(params[:id])
    # @destroy_comment = Comment.find(params[:user_id]).comments.find(comment_param)
    @destroy_comment.destroy
    redirect_to user_path(params[:user_id])
  end

  def comment_param
    params.require(:comment).permit(:comment)
  end

end
