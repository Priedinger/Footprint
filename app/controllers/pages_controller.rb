class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @title = "Dashboard"
    if current_user
      @favorites = current_user.favorites
      @tickets = current_user.tickets
    end
  end

  def settings
    @title = "Settings"
  end

end
