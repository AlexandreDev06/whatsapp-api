class SendMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    response = Whatsapp::SendMessage.new(User.first).call(message_id)
    message = Message.find(message_id)
    if response['status'] == 'SENDED'
      message.update!(status: 'sended')
    else
      message.update(status: 'error', error_description: response['message'])
    end
  end
end
