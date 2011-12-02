class PagesController < ApplicationController
  def home
    @title = 'Home'
    if signed_in?
      @micropost= Micropost.new 
      # The home action with a paginated feed.
      # Note that the paginate method actually reaches 
      #   all the way into the Micropost model method 
      #         in Listing 12.45, 
      #         arranging to pull out only 30 microposts 
      #          at a time from the database.
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About'
  end

  def help
    @title = 'Help'
  end
end
