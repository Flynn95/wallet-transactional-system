# == Schema Information
#
# Table name: wallets
#
#  unique_address  :string           not null, primary key
#  attachable_type :string           not null
#  attachable_id   :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Wallet < ApplicationRecord
  has_many :transactions, foreign_key: :source_wallet_id
  belongs_to :attachable, polymorphic: true

  before_create :set_unique_address

  def current_balance
    transactions.sum(:amount)
  end

  def set_unique_address
    unique_id = SecureRandom.uuid
    unique_id = SecureRandom.uuid while Wallet.exists?(unique_address: unique_id)
    self.unique_address = unique_id
  end
end
