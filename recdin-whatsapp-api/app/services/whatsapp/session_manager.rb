module Whatsapp
  class SessionManager < BaseService
    def start_session
      response = HTTParty.post(
        "#{api_url}/start-session",
        headers: { Authorization: "Bearer #{user.wpp_bearer_token}" },
        body: { webhook: user.wpp_bearer_token }.to_json
      )
      body = JSON.parse(response.body)
      return 'Starting service....' if body['status'] == 'CLOSED'

      return 'Session already started.' if body['status'] == 'QRCODE' && body['qrcode'].present?

      body
    end

    def status_session
      response = HTTParty.get(
        "#{api_url}/status-session",
        headers: { Authorization: "Bearer #{user.wpp_bearer_token}" }
      )
      body = JSON.parse(response.body)
      if body['status'] == 'QRCODE'
        { status: 'QRCODE', qrcode: body['qrcode'] }
      else
        { status: body['status'], message: cases_status[body['status']] }
      end
    end

    def generate_token
      response = HTTParty.post("#{api_url}/#{api_secret_key}/generate-token")
      response_body = JSON.parse(response.body)
      user.update! wpp_bearer_token: response_body['token']
    end

    private

    def cases_status
      {
        'CLOSED' => 'Session closed.',
        'INITIALIZING' => 'Session started. Generating QRCode.',
        'CONNECTED' => 'Session connected.'
      }
    end
  end
end
