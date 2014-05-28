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
  end

  def chapitre
  end

  def personne
  end
end
