class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # Or scope.where("name LIKE 't%'")
      # Or user.admin? ? scope.all : scope.where(user: user)
    end
  end

  def index?
    true
  end

  def nearby?
    true
  end

  def following?
    true
  end

  def search?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

end
