# == Schema Information
#
# Table name: transaction_types
#
#  id               :bigint           not null, primary key
#  transaction_type :integer          not null
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class TransactionType < ApplicationRecord
  enum transaction_type: { deposit: 0, withdraw: 1, transfer: 2 }
end
