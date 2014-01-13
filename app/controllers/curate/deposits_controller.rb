class Curate::DepositsController < ApplicationController
  def new
    deposit
    render text: "Hello"
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

end
