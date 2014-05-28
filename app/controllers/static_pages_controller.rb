class StaticPagesController < ApplicationController

  def home 
  end

  def help
  end

  def about
  end

  def anecdote
    if signed_in?
      @anecdote  = current_user.anecdotes.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def scene
    if signed_in?
      @scene  = current_user.scenes.build
      @feed_items_scene = current_user.feed_scene.paginate(page: params[:page])
    end
  end

  def chapitre
    if signed_in?
      @chapitre  = current_user.chapitres.build
      @feed_items_chapitre = current_user.feed_chapitre.paginate(page: params[:page])
    end
  end

  def personne
    if signed_in?
      @personne  = current_user.personnes.build
      @feed_items_personne = current_user.feed_personne.paginate(page: params[:page])
    end
  end
end
