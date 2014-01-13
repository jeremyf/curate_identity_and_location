require 'spec_helper'

describe Curate::DepositsController do

  before :each do
    controller.stub(:render)
  end

  context 'GET #new action' do
    context 'assigned @deposit' do
      let(:form) { double('Form') }
      let(:deposit_attributes) { {"title" => 'My Title'} }
      it 'should be created based on location' do
        Curate::DepositForm.should_receive(:build).with(
          context: controller,
          location: 'location_name',
          as: 'identity_name',
          deposit_type: 'deposit_type_name'
        ).and_return(form)
        form.should_receive(:attributes=).with(deposit_attributes)

        get :new, location: 'location_name', as: 'identity_name', deposit_type: 'deposit_type_name', deposit: deposit_attributes
        expect(assigns(:deposit)).to eq(form)
      end
    end
  end

end
