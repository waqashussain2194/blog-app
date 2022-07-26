# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user&.has_role?(:admin)
        scope.all
      else
        scope.where(approved: true)
      end
    end
  end

  def index?
    true
  end

  def new?
    user_is_logged_in?
  end

  def create?
    user_is_logged_in?
  end

  def edit?
    user_is_logged_in? && (user_is_owner_of_post? || @user.has_role?(:admin))
  end

  def show?
    true
  end

  def update?
    user_is_logged_in? && (user_is_owner_of_post? || @user.has_role?(:admin))
  end

  def destroy?
    user_is_logged_in? && (user_is_owner_of_post? || @user.has_role?(:moderator) || @user.has_role?(:admin))
  end

  def accept_post?
    @user.has_role?(:moderator)
  end

  private

  def user_is_owner_of_post?
    @user == @record.user
  end
end
