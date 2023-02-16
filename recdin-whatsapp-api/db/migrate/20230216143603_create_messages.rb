class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.datetime :will_send_at
      t.boolean :sended, default: false
      t.datetime :sended_at
      t.string :phone_number

      t.timestamps
    end
  end
end
