class BugPolicy < ApplicationPolicy
  # Anyone logged in can view the list of bugs or a specific bug
  def index?
    true
  end

  def show?
    true
  end

  # Anyone can report/create a bug
  def create?
    true
  end

  # Only the person who created the bug OR the user assigned to it can update it
  def update?
    user.id == record.creator_id || user.id == record.assignee_id
  end

  # Only the creator of the bug can delete it entirely
  def destroy?
    user.id == record.creator_id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
