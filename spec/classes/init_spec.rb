require 'spec_helper'
describe 'bsl_infrastructure' do

  context 'with default values for all parameters' do
    it { should contain_class('bsl_infrastructure') }
  end
end
