class FollowPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def followings?
    true
  end

  def followers?
    true
  end

  def create?
    record == user
  end

  def destroy?
    record == user
  end

end
