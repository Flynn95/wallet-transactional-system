# == Schema Information
#
# Table name: transaction_statuses
#
#  id          :bigint           not null, primary key
#  status      :integer          not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class TransactionStatus < ApplicationRecord
  enum status: { successful: 0, failed: 1 }
end
