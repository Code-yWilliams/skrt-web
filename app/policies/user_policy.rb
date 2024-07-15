class UserPolicy < ApplicationPolicy
  # Called from API sessions controller
  def create_auth_tokens?
    # Users are only allowed to create their own auth tokens
    record.is_a?(User)
  end

  def destroy_auth_tokens?
    # Users are only allowed to destroy their own auth tokens
    record.is_a?(User) && record.id == user.id
  end
end
