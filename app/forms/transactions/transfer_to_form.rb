module Transactions
  class TransferToForm < BaseTransactionForm
    validates :amount, numericality: { greater_than: 0 }
    validates :source_wallet_id, presence: true
    validates :destination_wallet_id, presence: true

    validate :source_wallet_exists
    validate :destination_wallet_exists
    validate :source_differs_from_destination
  end
end
