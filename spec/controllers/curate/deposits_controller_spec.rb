require 'spec_helper'

describe Curate::DepositsController do
  context 'GET #new action' do
    context 'assigned @deposit' do
      let(:form) { double }
      it 'should be created based on location' do
        Curate::DepositForm.should_receive(:build).with(
          context: controller,
          location: 'location_name',
          as: 'identity_name',
          deposit_type: 'deposit_type_name'
        ).and_return(form)
        get :new, location: 'location_name', as: 'identity_name', deposit_type: 'deposit_type_name'
        expect(assigns(:deposit)).to eq(form)
      end
    end
  end
end
