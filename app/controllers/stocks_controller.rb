class StocksController < ApplicationController
  def new
    @stock = Stock.new
  end

  def create
    form = WalletOwners::RegistrationForm.new(stock_params.merge(model_type: 'Stock'))

    if form.submit
      flash[:success] = 'Stock created successfully.'
      redirect_to accounts_transactions_path
    else
      @messages = form.errors.full_messages
      @stock = Stock.new(stock_params)
      render :new
    end
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def update
    form = WalletOwners::UpdateForm.new(stock_params.merge(model_type: 'Stock', id: params[:id]))

    if form.submit
      flash[:success] = 'Stock updated successfully.'
      redirect_to accounts_transactions_path
    else
      @messages = form.errors.full_messages
      @stock = Stock.find(params[:id]).assign_attributes(stock_params)
      render :edit
    end
  end

  def destroy
    stock = Stock.find(params[:id])
    stock.wallet&.destroy!
    stock.destroy!

    flash[:success] = 'Stock destroyed successfully.'

    redirect_to accounts_transactions_path
  end

  private

  def stock_params
    params.fetch(:stock, {}).permit(:name)
  end
end
