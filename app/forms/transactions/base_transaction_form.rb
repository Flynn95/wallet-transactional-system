module Transactions
  class BaseTransactionForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :source_wallet_id, :string
    attribute :destination_wallet_id, :string
    attribute :amount, :integer
    attribute :transaction_status_id, :integer
    attribute :transaction_type_id, :integer

    validates :source_wallet_id, presence: true
    validates :amount, presence: true

    def submit
      return unless validate

      Transaction.create!(attributes)
      true
    end

    def persisted?
      false
    end

    protected

    def source_wallet_exists
      errors.add(:source_wallet_id, :required) unless Wallet.exists?(unique_address: source_wallet_id)
    end

    def destination_wallet_exists
      errors.add(:destination_wallet_id, :required) unless Wallet.exists?(unique_address: destination_wallet_id)
    end

    def source_differs_from_destination
      errors.add(:source_wallet_id, :other_than, { count: 'destination wallet' }) if source_wallet_id == destination_wallet_id
    end
  end
end
