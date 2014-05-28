class PersonnesController < ApplicationController
  before_action :signed_in_user

  def create
    @personne = current_user.personnes.build(personne_params)
    if @personne.save
      flash[:success] = "Personne creee!"
      redirect_to :back
    else
      @feed_items_personne = []
      flash[:error] = "Vous devez au moins remplir le champs du nom !"
      redirect_to :back
    end
  end

  def destroy
  end

  private

    def personne_params
      params.require(:personne).permit(:nom)
    end
end
