class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    form = WalletOwners::RegistrationForm.new(user_params.merge(model_type: 'User'))

    if form.submit
      flash[:success] = 'User created successfully.'
      redirect_to accounts_transactions_path
    else
      @messages = form.errors.full_messages
      @user = User.new(user_params)
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    form = WalletOwners::UpdateForm.new(user_params.merge(model_type: 'User', id: params[:id]))

    if form.submit
      flash[:success] = 'User updated successfully.'
      redirect_to accounts_transactions_path
    else
      @messages = form.errors.full_messages
      @user = User.find(params[:id]).assign_attributes(user_params)
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.wallet&.destroy!
    user.destroy!

    flash[:success] = 'User destroyed successfully.'

    redirect_to accounts_transactions_path
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:name)
  end
end
