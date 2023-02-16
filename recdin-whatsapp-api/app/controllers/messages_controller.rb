class MessagesController < ApplicationController
  def send_message
    response = Whatsapp::SessionManager.new(@user).status_session
    if response[:status] == 'CONNECTED'
      will_send_at = set_time_will_send + rand(1..3).seconds
      message = Message.create!(message_params.merge({ will_send_at: }))
      SendMessageWorker.perform_at(will_send_at, message.id)
      render json: { status: 'SENDED', message: "Message will sent at: #{format_time(will_send_at)}" }, status: :ok
    else
      render json: { status: response[:status], message: 'Whatsapp is not connected' }, status: :not_acceptable
    end
  end

  private

  def message_params
    params.permit(:text, :phone_number)
  end

  def format_time(will_send_at)
    time = will_send_at - Time.zone.now
    if time < 60.seconds
      "#{time.to_i} seconds"
    elsif time < 60.minutes
      "#{time.to_i / 60} minutes"
    else
      "#{time.to_i / 60 / 60} hours"
    end
  end

  def set_time_will_send
    if Message.last.present?
      [Message.last.will_send_at, Time.zone.now].max
    else
      Time.zone.now
    end
  end
end
