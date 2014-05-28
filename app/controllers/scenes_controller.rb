class ScenesController < ApplicationController
  before_action :signed_in_user

  def create
    @scene = current_user.scenes.build(scene_params)
    if @scene.save
      flash[:success] = "Scene creee!"
      redirect_to :back
    else
      @feed_items_scene = []
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def scene_params
      params.require(:scene).permit(:lieu, :date, :recit)
    end
end
