class CreateApiClients < ActiveRecord::Migration[7.0]
  def change
    create_table :api_clients do |t|
      t.string :client_name, null: false
      t.string :client_secret, null: false

      t.timestamps
    end

    add_index :api_clients, :client_name, unique: true
    add_index :api_clients, :client_secret, unique: true
  end
end
