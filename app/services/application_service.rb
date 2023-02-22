class ApplicationService
  Response = Struct.new(:success?, :message, :code)

  def log(message, exception_message = nil)
    log_tag = "[#{self.class.name.upcase}] "
    Rails.logger.error log_tag + message
    Rails.logger.error log_tag + exception_message if exception_message.present?
  end
end
