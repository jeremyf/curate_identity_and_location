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

  def assert_attribute_assignment
    form.should_receive(:attributes=).with(deposit_attributes)
  end

  def assert_form_is_saved
    form.should_receive(:save)
  end

  before :each do
    controller.stub(:render)
  end

  context 'GET #new action' do
    context 'assigned @deposit' do
      let(:form) { double('Form') }
      let(:deposit_attributes) { {"title" => 'My Title'} }
      it 'should be instantiated based on location' do
        stub_form_building
        assert_attribute_assignment
        get :new, location: 'location_name', as: 'identity_name', deposit_type: 'deposit_type_name', deposit: deposit_attributes
        expect(assigns(:deposit)).to eq(form)
      end
    end
  end

  context 'POST #create action' do
    context 'assigned @deposit' do
      let(:form) { double('Form') }
      let(:deposit_attributes) { {"title" => 'My Title'} }
      it 'should be instantiated based on location' do
        stub_form_building
        assert_attribute_assignment
        assert_form_is_saved

        post :create, location: 'location_name', as: 'identity_name', deposit_type: 'deposit_type_name', deposit: deposit_attributes
        expect(assigns(:deposit)).to eq(form)
      end
    end
  end

end
