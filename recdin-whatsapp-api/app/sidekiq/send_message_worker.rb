class SendMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    Whatsapp::SendMessage.new(User.first).call(message_id)
  end
end
