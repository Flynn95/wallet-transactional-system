module Transactions
  class WithdrawService < BaseService
    attr_reader :withdraw_params

    def initialize(withdraw_params:)
      @withdraw_params = withdraw_params
      @withdraw_params[:amount] = -@withdraw_params[:amount].to_i
    end

    def execute
      form = Transactions::WithdrawForm.new(withdraw_form_attributes)

      [form, form.submit]
    end

    private

    def withdraw_form_attributes
      success_status = TransactionStatus.successful.first
      withdraw_type = TransactionType.withdraw.first
      withdraw_params.merge(transaction_status_id: success_status.id, transaction_type_id: withdraw_type.id)
    end
  end
end
