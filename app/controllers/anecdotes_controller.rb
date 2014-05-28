class AnecdotesController < ApplicationController
  before_action :signed_in_user
  before_filter   :signed_in_user,    only: [:create, :destroy]
  before_filter   :correct_user, only: :destroy

  def create
    @anecdote = current_user.anecdotes.build(anecdote_params)
    if @anecdote.save
      flash[:success] = "Anecdote creee!"
      redirect_to :back
    else
      @feed_items = []
      flash[:error] = "Vous devez au moins remplir les champs du sujet, du theme et du recit!"
      redirect_to :back
    end
  end

  def destroy
    @anecdote.destroy
    flash[:success] = "Anecdote supprimee!"
    redirect_to :back
  end

  private

    def anecdote_params
      params.require(:anecdote).permit(:sujet, :theme, :texte)
    end

    def correct_user
      @anecdote = current_user.anecdotes.find_by(id: params[:id])
      redirect_to root_url if @anecdote.nil?
    end
end
