class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
