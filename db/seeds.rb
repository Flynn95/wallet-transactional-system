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

if User.all.blank?
  3.times do
    User.create!(name: Faker::Name.name)
  end
end

if Stock.all.blank?
  Stock.create!(name: 'Bitcoin')
  Stock.create!(name: 'Ethereum')
  Stock.create!(name: 'Litecoin')
end

if Team.all.blank?
  3.times do |n|
    Team.create!(name: "Team #{n + 1}")
  end
end

if Wallet.all.blank?
  User.all.each do |user|
    user.create_wallet!(attachable: user)
  end
  Stock.all.each do |stock|
    stock.create_wallet!(attachable: stock)
  end
  Team.all.each do |team|
    team.create_wallet!(attachable: team)
  end
end

if Transaction.all.blank?
  User.all.each do |user|
    user.wallet.transactions.create!(transaction_type: TransactionType.deposit.first, transaction_status: TransactionStatus.successful.first, amount: 1000)
  end
end
