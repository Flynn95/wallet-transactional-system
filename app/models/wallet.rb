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

  def current_balance
    transactions.sum(:amount)
  end
end
