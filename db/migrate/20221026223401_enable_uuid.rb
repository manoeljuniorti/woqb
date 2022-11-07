class EnableUuid < ActiveRecord::Migration[4.2]
  def change
    enable_extension 'pgcrypto'
  end
end