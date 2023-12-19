class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :source_wallet_id, null: false
      t.string :destination_wallet_id

      t.integer :amount, null: false
      t.integer :transaction_status_id, null: false
      t.integer :transaction_type_id, null: false

      t.timestamps
    end

    add_index :transactions, :source_wallet_id
    add_index :transactions, :destination_wallet_id
    add_index :transactions, :transaction_status_id
    add_index :transactions, :transaction_type_id
  end
end
