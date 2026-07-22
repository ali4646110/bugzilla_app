class ProjectPolicy < ApplicationPolicy
  # Everyone who is logged in can view the list of projects
  def index?
    true
  end

  # Everyone who is logged in can see a specific project
  def show?
    true
  end

  # Only managers can create new projects
  def create?
    user.user_type == "manager"
  end

  # Only managers can edit projects
  def update?
    user.user_type == "manager"
  end

  # Only managers can delete projects
  def destroy?
    user.user_type == "manager"
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
