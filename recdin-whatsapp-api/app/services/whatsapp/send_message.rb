module Whatsapp
  class SendMessage < BaseService
    def call(message_id)
      @message = Message.find(message_id)
      check_contact_exist
      send_message
      { status: 'Sended' }
    rescue StandardError => e
      { status: 'ERROR', message: e.message }
    end

    private

    def check_contact_exist
      response = HTTParty.get(
        "#{api_url}/contact/#{@message.phone_number}",
        headers: { Authorization: "Bearer #{user.wpp_bearer_token}" }
      )
      body = JSON.parse(response.body)
      raise 'Contact not found in Whatsapp.' if body['response']['isWAContact'] == false
    end

    def send_message
      response = HTTParty.post(
        "#{api_url}/send-message",
        headers: { Authorization: "Bearer #{user.wpp_bearer_token}", 'Content-Type': 'application/json' },
        body: { phone: @message.phone_number, message: @message.text, isGroup: false }.to_json
      )
      body = JSON.parse(response.body)
      return unless body['status'] == 'success'

      @message.update!(sended_at: Time.zone.now, sended: true)
    end
  end
end
