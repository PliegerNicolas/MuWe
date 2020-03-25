class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.user == user
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end

  def update?
    create?
  end
end
