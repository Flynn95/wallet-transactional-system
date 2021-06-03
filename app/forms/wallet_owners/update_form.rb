module WalletOwners
  class UpdateForm < BaseForm
    attribute :id, :integer

    validates :id, presence: true

    def submit
      return unless validate

      owner = model_type.constantize.find(attributes['id'])
      owner.update!(attributes.except('model_type'))

      true
    end
  end
end
