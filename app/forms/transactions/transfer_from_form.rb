module Transactions
  class TransferFromForm < BaseTransactionForm
    validates :amount, numericality: { less_than: 0 }
    validates :source_wallet_id, presence: true
    validates :destination_wallet_id, presence: true

    validate :source_wallet_exists
    validate :destination_wallet_exists
    validate :source_differs_from_destination
    validate :valid_transfer_amount

    private

    def valid_transfer_amount
      return if Wallet.find_by(unique_address: source_wallet_id).current_balance >= amount.abs

      errors.add(:amount, :invalid)
    end
  end
end
