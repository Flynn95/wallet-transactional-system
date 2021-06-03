# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if TransactionType.all.blank?
  TransactionType.transaction_types.each do |type, enum|
    TransactionType.create!(transaction_type: enum, description: "#{type.capitalize} Transaction Type")
  end
end

if TransactionStatus.all.blank?
  TransactionStatus.statuses.each do |type, enum|
    TransactionStatus.create!(status: enum, description: "#{type.capitalize} Transaction")
  end
end
