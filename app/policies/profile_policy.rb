class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def profile?
    true
  end

  def update?
    user == record.user
  end

  def save_location?
    true
  end
end
