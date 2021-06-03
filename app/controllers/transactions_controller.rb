class TransactionsController < ApplicationController
  before_action :fetch_sources, only: %i[accounts new_deposit new_withdraw new_transfer]

  def index
    @transactions = Transaction.all.order(created_at: :desc)
  end

  def accounts; end

  def new_deposit; end

  def new_withdraw; end

  def new_transfer; end

  def deposit
    form, result = Transactions::DepositService.execute(deposit_params: deposit_withdraw_params)

    if result
      flash[:success] = 'Deposited successfully.'
      redirect_to transactions_path
    else
      @messages = form.errors.full_messages
      fetch_sources
      render :new_deposit
    end
  end

  def withdraw
    form, result = Transactions::WithdrawService.execute(withdraw_params: deposit_withdraw_params)

    if result
      flash[:success] = 'Withdrawn successfully.'
      redirect_to transactions_path
    else
      @messages = form.errors.full_messages
      fetch_sources
      render :new_withdraw
    end
  end

  def transfer
    full_messages, result = Transactions::TransferService.execute(transfer_params: transfer_params)

    if result
      flash[:success] = 'Transferred successfully.'
      redirect_to transactions_path
    else
      @messages = full_messages
      fetch_sources
      render :new_transfer
    end
  end

  private

  def fetch_sources
    @sources = Wallet.all.includes(:attachable)
  end

  def deposit_withdraw_params
    params.fetch(:transaction, {}).permit(:source_wallet_id, :amount)
  end

  def transfer_params
    params.fetch(:transaction, {}).permit(:source_wallet_id, :destination_wallet_id, :amount)
  end
end
