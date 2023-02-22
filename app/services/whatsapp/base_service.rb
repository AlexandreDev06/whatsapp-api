module Whatsapp
  class BaseService < ApplicationService
    attr_accessor :user

    def initialize(user)
      self.user = user
    end

    protected

    def api_url
      "#{ENV.fetch('WHATSAPP_URL_LOCALHOST')}/api/#{user.uuid_session}"
    end

    def api_secret_key
      ENV.fetch('WHATSAPP_SECRET_KEY')
    end
  end
end
