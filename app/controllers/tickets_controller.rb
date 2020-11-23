class TicketsController < ApplicationController

  def index
    @tickets = current_user.tickets
  end
end
