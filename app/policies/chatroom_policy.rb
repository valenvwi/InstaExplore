class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where("owner_id = ? OR guest_id = ?", user.id, user.id)
    end
  end

  def index?
    true
  end

  def show?
    # record == user
    true
  end

  def create?
    true
  end

end
