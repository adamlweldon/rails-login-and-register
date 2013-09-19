class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def index
    @user = User.all
  end  

  def create
  	@user = User.new(user_param)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      # render :text => "here"
      render action: "new"
    end
  end

  def show
  	@user = User.find(params[:id])
    #to display comments per product
    @comment = @user.comments.build
    @user_comments = @user.comments.order("created_at DESC")
  end

  private 
  def user_param
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
