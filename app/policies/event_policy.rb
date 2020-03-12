class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def jams?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def destroy?
    user == record.user
  end

  def nearby?
    true
  end
end
