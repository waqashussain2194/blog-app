# frozen_string_literal: true

class SuggestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user&.has_role?(:admin)
        scope.all
      else
        scope.where(@user == scope.user)
      end
    end
  end

  def new?
    user_is_logged_in?
  end

  def create?
    user_is_logged_in?
  end

  def destroy?
    user_is_owner_of_post? || user.has_role?(:admin)
  end

  def accept?
    user_is_owner_of_post?
  end

  private

  def user_is_owner_of_suggestion?
    user == @record.user
  end

  def user_is_owner_of_post?
    @user == @record.post.user
  end
end
