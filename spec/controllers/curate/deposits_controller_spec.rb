require 'spec_helper'

describe Curate::DepositsController do
  context 'GET #new action' do
    it 'should assign a deposit form that responds to attributes' do
      get :new
      expect(assigns(:deposit)).to respond_to(:attributes)
    end
  end
end
