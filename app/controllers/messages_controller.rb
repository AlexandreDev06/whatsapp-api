class MessagesController < ApplicationController
  def send_message
    response = Whatsapp::SessionManager.new(@user).status_session
    if response[:status] == 'CONNECTED'
      will_send_at = call_worker_at
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

  def call_worker_at
    start_time, end_time = start_and_finish_hours
    time = Time.zone.now
    if time.between? end_time, start_time
      time_remaining = update_time_remaining(time, start_time)
      time += time_remaining.hour.hours + time_remaining.min.minutes
      time_is_less_than_last_message?(time)
    else
      set_time_will_send + rand(30..60).seconds
    end
  end

  def set_time_will_send
    if Message.last.present?
      [Message.last.will_send_at, Time.zone.now].max
    else
      Time.zone.now
    end
  end

  def start_and_finish_hours
    [Time.zone.now.midnight + 7.hours,
     Time.zone.now.midnight]
  end

  def update_time_remaining(time, start_time)
    hour_now = time.hour.hours + time.min.minutes
    start_time.ago hour_now
  end

  def time_is_less_than_last_message?(time)
    if time < Message.last.will_send_at
      Message.last.will_send_at + rand(30..60).seconds
    else
      time
    end
  end
end
