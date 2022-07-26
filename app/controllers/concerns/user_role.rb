# frozen_string_literal: true

module UserRole
  extend ActiveSupport::Concern

  def role?(role)
    current_user&.has_role?(role)
  end
end
