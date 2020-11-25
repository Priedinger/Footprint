class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.all
      scope.all
    end
  end


end
