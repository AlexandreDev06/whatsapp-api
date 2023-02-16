class User < ApplicationRecord
  def wpp_bearer_token
    Whatsapp::SessionManager.new(self).generate_token if read_attribute(:wpp_bearer_token).blank?

    read_attribute(:wpp_bearer_token)
  end
end
