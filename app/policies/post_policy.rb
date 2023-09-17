class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def nearby?
    true
  end

  def edit?
    record.user_id == user.id
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
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end
end
