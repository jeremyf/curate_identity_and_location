require 'spec_helper'

describe Curate::DepositsController do

  def stub_form_building
    Curate::DepositForm.should_receive(:build).with(
      context: controller,
      location: 'location_name',
      as: 'identity_name',
      deposit_type: 'deposit_type_name'
    ).and_return(form)
  end

  def stub_attribute_assignment
    form.should_receive(:attributes=).with(deposit_attributes)
  end

  def stub_form_save
    form.should_receive(:save)
  end

  before :each do
    controller.stub(:render)
  end

  context 'GET #new action' do
    context 'assigned @deposit' do
      let(:form) { double('Form') }
      let(:deposit_attributes) { {"title" => 'My Title'} }
      it 'should be created based on location' do
        stub_form_building
        stub_attribute_assignment
        get :new, location: 'location_name', as: 'identity_name', deposit_type: 'deposit_type_name', deposit: deposit_attributes
        expect(assigns(:deposit)).to eq(form)
      end
    end
  end

  context 'POST #create action' do
    context 'assigned @deposit' do
      let(:form) { double('Form') }
      let(:deposit_attributes) { {"title" => 'My Title'} }
      it 'should be created based on location' do
        stub_form_building
        stub_attribute_assignment
        stub_form_save
        post :create, location: 'location_name', as: 'identity_name', deposit_type: 'deposit_type_name', deposit: deposit_attributes
        expect(assigns(:deposit)).to eq(form)
      end
    end
  end

end
