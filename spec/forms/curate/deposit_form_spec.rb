require 'spec_helper'

describe Curate::DepositForm do
  subject { Curate::DepositForm.new }
  its(:attributes) { should be_a_kind_of(Enumerable) }
end