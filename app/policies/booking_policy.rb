class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: @user.id)
    end
  end
  def index?
    true
  end
  def create?
    true
  end
    def edit?
    true
  end
    def destroy?
    true
  end

end
