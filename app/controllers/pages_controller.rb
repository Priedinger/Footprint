class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @title = "Dashboard"
    if current_user
      @favorites = current_user.favorites
      @tickets = current_user.tickets
     end
     @global_tickets_score
  end

  def settings
    @title = "Settings"
  end

  private

  def global_score
    @tickets = current_user.tickets
    @global_tickets = @tickets.map do |ticket|
      calculate_ticket_score(ticket)
    end
    if @tickets.size == 0
      @global_tickets_score = 0
    else
      @global_tickets_score = @global_tickets.reduce(0, :+) / @tickets.size
    end
  end

  def calculate_ticket_score(ticket)
    total_score = 0
    ticket.items.where.not(product_id: nil).each do |item|
      total_score += item.product.score
    end
    ticket_items_count = ticket.items.where.not(product_id: nil).count
    if ticket_items_count.zero?
      ticket_score = 0
    else
      ticket_score = total_score / ticket.items.where.not(product_id: nil).count
    end
  end

end
