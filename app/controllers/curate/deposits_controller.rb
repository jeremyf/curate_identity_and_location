class Curate::DepositsController < ApplicationController
  respond_to :html
  class_attribute :new_deposit_form_builder
  self.new_deposit_form_builder = lambda {|*args| Curate::DepositForm.build(*args) }

  def new
    validate_request(deposit)
    assign_attributes(deposit)
    respond_with(deposit)
  end

  def create
    validate_request(deposit)
    assign_attributes(deposit)
    create_deposit(deposit)
    respond_with(deposit)
  end

  protected
  def deposit
    @deposit ||= new_deposit_form_builder.call(
      {
        context: self,
        location: params.fetch(:location),
        deposit_type: params.fetch(:deposit_type),
        as: params.fetch(:as)
      }
    )
  end

  def validate_request(object)
    # This can be pushed down to the deposit form building
  end

  def assign_attributes(object)
    object.attributes = params[:deposit]
  end

  def create_deposit(object)
    object.save
  end

end
