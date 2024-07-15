module UserAuthTokenOverrides
  extend ActiveSupport::Concern
  
  included do
    def mobile_auth_token
      update!(mobile_auth_token: Devise.friendly_token) if self[:mobile_auth_token].blank?

      self[:mobile_auth_token]
    end
  end
end
