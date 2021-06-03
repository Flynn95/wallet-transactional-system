# == Schema Information
#
# Table name: stocks
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Stock < ApplicationRecord
  has_one :wallet, as: :attachable
end
