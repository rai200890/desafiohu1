require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'Validations' do
    context 'city with a name' do
      let(:city){FactoryGirl.build(:city)}
      it 'should be valid' do
        expect(city).to be_valid
      end
    end
    context 'city without a name' do
      it 'should be invalid' do
        expect(City.new).to be_invalid
      end
    end
  end
end
