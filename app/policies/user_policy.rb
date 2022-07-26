# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def profile?
    true if @user&.has_role?(:moderator)
  end

  def accept_post?
    true if @user&.has_role?(:moderator)
  end
end
