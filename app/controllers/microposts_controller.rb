class MicropostsController < ApplicationController 
  before_filter :signed_in_user, only: [:create,:destroy]
  before_filter :correct_user, only: [:destroy]
 
  def create
    #binding.pry 
    @micropost = current_user.microposts.build(params[:micropost])
    #@micropost = current_user.microposts.build(micropost_params)
    #binding.pry
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path 
    else
      @feed_items = []
      render 'static_pages/home' 
    end
  end
 
 
  def destroy 
    #binding.pry 
    @micropost.destroy
    redirect_to root_path 
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
    #def correct_user
    #  @micropost = current_user.microposts.find(params[:id])
    #rescue
    #  redirect_to root_url 
    #end
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end
