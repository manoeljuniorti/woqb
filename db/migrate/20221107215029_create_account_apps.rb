class CreateAccountApps < ActiveRecord::Migration[6.0]
  def change
    create_table :account_apps, id: :uuid do |t|
      t.string :name
      t.string :tenant
      t.references :client_app, null: false, foreign_key: true, type: :uuid
      t.json :quick_books_data

      t.timestamps
    end
  end
end
