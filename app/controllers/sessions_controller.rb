class SessionsController < ApplicationController
  def new 
  end
  def create 
    user = User.find_by_email(params[:session][:email].downcase)
    ##binding.pry
    #用户存在并且认证成功
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user 
    else
      #认证失败
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end
  def destroy 
    sign_out
    redirect_to root_path
  end
end
