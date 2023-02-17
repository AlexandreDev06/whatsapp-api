class AddStatusAndErrorDescriptionToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :status, :integer, null: true
    add_column :messages, :error_description, :string, null: true
  end
end
