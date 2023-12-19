# == Schema Information
#
# Table name: transactions
#
#  id                    :string           not null, primary key
#  source_wallet_id      :string           not null
#  destination_wallet_id :string
#  amount                :integer          not null
#  transaction_status_id :integer          not null
#  transaction_type_id   :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', foreign_key: :source_wallet_id
  belongs_to :destination_wallet, class_name: 'Wallet', foreign_key: :destination_wallet_id, optional: true

  belongs_to :transaction_type
  belongs_to :transaction_status
end
