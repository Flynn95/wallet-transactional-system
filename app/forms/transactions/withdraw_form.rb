module Transactions
  class WithdrawForm < BaseTransactionForm
    validates :amount, numericality: { less_than: 0 }

    validate :valid_withdraw_amount

    private

    def valid_withdraw_amount
      return if Wallet.find_by(unique_address: source_wallet_id).current_balance >= amount.abs

      errors.add(:amount, :invalid)
    end
  end
end
