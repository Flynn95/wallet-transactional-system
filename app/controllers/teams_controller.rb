class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    form = WalletOwners::RegistrationForm.new(team_params.merge(model_type: 'Team'))

    if form.submit
      flash[:success] = 'Team created successfully.'
      redirect_to accounts_transactions_path
    else
      @messages = form.errors.full_messages
      @team = Team.new(team_params)
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    form = WalletOwners::UpdateForm.new(team_params.merge(model_type: 'Team', id: params[:id]))

    if form.submit
      flash[:success] = 'Team updated successfully.'
      redirect_to accounts_transactions_path
    else
      @messages = form.errors.full_messages
      @team = Team.find(params[:id]).assign_attributes(team_params)
      render :edit
    end
  end

  def destroy
    team = Team.find(params[:id])
    team.wallet&.destroy!
    team.destroy!

    flash[:success] = 'Team destroyed successfully.'

    redirect_to accounts_transactions_path
  end

  private

  def team_params
    params.fetch(:team, {}).permit(:name)
  end
end
