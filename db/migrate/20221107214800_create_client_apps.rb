class CreateClientApps < ActiveRecord::Migration[6.0]
  def change
    create_table :client_apps, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :public_key
      t.string :secret_key
      t.boolean :active

      t.timestamps
    end
  end
end
