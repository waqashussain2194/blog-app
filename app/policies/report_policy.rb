# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user&.has_role?(:admin)
        scope.all
      else
        scope.where(@user == scope.user)
      end
    end
  end

  def create?
    user_is_logged_in?
  end

  def destroy?
    user_is_owner_of_report? || @user.has_role?(:admin)
  end

  private

  def user_is_owner_of_report?
    @user == @record.user
  end
end
