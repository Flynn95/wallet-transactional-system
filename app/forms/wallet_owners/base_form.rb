module WalletOwners
  class BaseForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :name, :string
    attribute :model_type, :string

    validates :name, presence: true

    def submit
      raise NotImplementedError
    end

    def persisted?
      false
    end
  end
end
