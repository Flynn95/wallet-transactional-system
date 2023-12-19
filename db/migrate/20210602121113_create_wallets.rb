class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table(:wallets, id: false) do |t|
      t.string :unique_address, primary_key: true

      t.string :attachable_type, null: false
      t.bigint :attachable_id, null: false

      t.timestamps
    end

    add_index :wallets, %i[attachable_type attachable_id]
  end
end
