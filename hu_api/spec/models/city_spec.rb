require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validations' do
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
    context 'already created city' do
      before :each do
        FactoryGirl.create(:city, :a)
      end
      let(:invalid_city){FactoryGirl.build(:city, :a) }
      it 'should be invalid' do
        expect(invalid_city).to be_invalid
      end
    end
  end
  describe 'scopes' do

  end
end
