class FollowPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # Or scope.where("name LIKE 't%'")
      # Or user.admin? ? scope.all : scope.where(user: user)
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
