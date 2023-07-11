class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
  def resolve
    scope.all
      # Or scope.where("name LIKE 't%'")
      # Or user.admin? ? scope.all : scope.where(user: user)
  end
  end

  def show?
    true
  end

  def create?
    true
  end

  def edit?
    record == user
  end

  def notification?
    true
  end

  def update?
    record == user
  end

  def destroy?
    true
  end

end
