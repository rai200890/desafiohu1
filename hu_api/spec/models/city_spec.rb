require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validations' do
    context 'city with a name' do
      let(:city){FactoryGirl.build(:city)}
      it 'is valid' do
        expect(city).to be_valid
      end
    end
    context 'city without a name' do
      it 'is invalid' do
        expect(City.new).to be_invalid
      end
    end
    context 'already created city' do
      before :each do
        FactoryGirl.create(:city, :a)
      end
      let(:invalid_city){FactoryGirl.build(:city, :a) }
      it 'is invalid' do
        expect(invalid_city).to be_invalid
      end
    end
  end
  describe 'scopes' do
    describe '.by_city_name' do
      let(:city){FactoryGirl.create(:city, name: 'RIO DE JANEIRO')}
      context 'city name that matches of one that exists with different case' do
        before :each do
          city
        end
        it 'includes hotels from that city' do
          expect(City.by_city_name("Rio de")).to include(city)
        end
      end
      context 'city name that doesn\'t match the name of one that exists' do
        let(:city){FactoryGirl.create(:city, name: 'São Paulo')}
        before :each do
          city
        end
        it 'returns empty' do
          expect(City.by_city_name('Rio de Janeiro')).not_to include(city)
        end
      end
    end
  end
end
