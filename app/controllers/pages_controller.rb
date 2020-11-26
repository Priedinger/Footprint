class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @title = "Dashboard"
  end

  def settings
    @title = "Settings"
  end

end
