require 'spec_helper'
describe 'rails' do
  context 'with default values for all parameters' do
    it { should contain_class('rails') }
  end
end
