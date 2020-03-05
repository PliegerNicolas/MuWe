class ParticipantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    raise
  end

  def accept?
    true
  end

  def decline?
    accept?
  end
end
