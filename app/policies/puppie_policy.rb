class PuppiePolicy < ApplicationPolicy
  class Scope < Scope

  def create?
    return true
  end


def update?
    record.user == user
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    record.user == user
  end

  def resolve
    scope.all
  end
  end


end
