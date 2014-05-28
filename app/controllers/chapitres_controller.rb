class ChapitresController < ApplicationController
  before_action :signed_in_user

  def create
    @chapitre = current_user.chapitres.build(chapitre_params)
    if @chapitre.save
      flash[:success] = "Chapitre cree!"
      redirect_to :back
    else
      @feed_items_chapitre = []
      flash[:error] = "Vous devez au moins remplir les champs du numero du chapitre et du titre !"
      redirect_to :back
    end
  end

  def destroy
  end

  private

    def chapitre_params
      params.require(:chapitre).permit(:num_chap, :titre)
    end
end
