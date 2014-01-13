class Curate::DepositsController < ApplicationController
  def new
    deposit
    render text: "Hello"
  end
  protected
  def deposit
    @deposit ||= Curate::DepositForm.new
  end
end
