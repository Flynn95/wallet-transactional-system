module WalletOwners
  class RegistrationForm < BaseForm
    def submit
      return unless validate

      ActiveRecord::Base.transaction do
        owner = model_type.constantize.create!(attributes.except('model_type'))
        Wallet.create!(attachable: owner)
      end

      true
    end
  end
end
