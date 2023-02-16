module Whatsapp
  class SendMessage < BaseService
    def call(message_id)
      message = Message.find(message_id)
      response = HTTParty.post(
        "#{api_url}/send-message",
        headers: { Authorization: "Bearer #{user.wpp_bearer_token}", 'Content-Type': 'application/json' },
        body: { phone: message.phone_number, message: message.text, isGroup: false }.to_json
      )
      body = JSON.parse(response.body)
      if body['status'] == 'success'
        message.update!(sended_at: Time.zone.now, sended: true)
      end
    end
  end
end
