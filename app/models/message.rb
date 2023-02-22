class Message < ApplicationRecord
  enum status: { sended: 0, error: 1 }
end
