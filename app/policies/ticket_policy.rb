class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user
  end

  def ticket_items?
    record.user == user
  end
end
