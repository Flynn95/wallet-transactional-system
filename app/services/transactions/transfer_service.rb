module Transactions
  class TransferService < BaseService
    attr_reader :transfer_params

    def initialize(transfer_params:)
      @transfer_params = transfer_params
    end

    def execute
      ActiveRecord::Base.transaction do
        source_form = Transactions::TransferFromForm.new(from_form_attributes)
        destination_form = Transactions::TransferToForm.new(to_form_attributes)

        result = source_form.submit && destination_form.submit
        return return_validation_error(source_form, destination_form) unless result

        [nil, result]
      end
    end

    private

    def return_validation_error(source_form, destination_form)
      msg = "#{source_form.errors.full_messages.to_sentence}\n#{destination_form.errors.full_messages.to_sentence}"
      [msg, false]
    end

    def from_form_attributes
      @from_form_attributes ||=
        {
          source_wallet_id: transfer_params[:source_wallet_id],
          destination_wallet_id: transfer_params[:destination_wallet_id],
          amount: -transfer_params[:amount].to_i,
          transaction_status_id: success_status.id,
          transaction_type_id: transfer_type.id
        }
    end

    def to_form_attributes
      @to_form_attributes ||=
        {
          source_wallet_id: transfer_params[:destination_wallet_id],
          destination_wallet_id: transfer_params[:source_wallet_id],
          amount: transfer_params[:amount].to_i,
          transaction_status_id: success_status.id,
          transaction_type_id: transfer_type.id
        }
    end

    def success_status
      @success_status ||= TransactionStatus.successful.first
    end

    def transfer_type
      @transfer_type ||= TransactionType.transfer.first
    end
  end
end
