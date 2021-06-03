module WalletOwners
  class RegistrationForm < BaseForm
    def submit
      return unless validate

      ActiveRecord::Base.transaction do
        owner = model_type.constantize.create!(attributes.except('model_type'))
        Wallet.create!(attachable: owner, unique_address: unique_wallet_id)
      end

      true
    end

    private

    def unique_wallet_id
      unique_address = SecureRandom.uuid
      unique_address = SecureRandom.uuid while Wallet.exists?(unique_address: unique_address)
      unique_address
    end
  end
end
