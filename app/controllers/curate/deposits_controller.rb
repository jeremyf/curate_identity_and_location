class Curate::DepositsController < ApplicationController
  respond_to :html
  def new
    validate_form_request(deposit)
    assign_attributes(deposit)
    respond_with(deposit)
  end
  protected
  def deposit
    @deposit ||= Curate::DepositForm.build(
      {
        context: self,
        location: params.fetch(:location),
        deposit_type: params.fetch(:deposit_type),
        as: params.fetch(:as)
      }
    )
  end

  def validate_form_request(deposit)
    # This can be pushed down to the deposit form building
  end

  def assign_attributes(object)
    object.attributes = params[:deposit]
  end
end
