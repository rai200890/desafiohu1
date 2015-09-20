require 'rails_helper'

RSpec.describe Hotel, type: :model do

  describe 'Validations' do
    let(:city_a){FactoryGirl.create(:city, :a)}
    context 'hotel with a name and a city' do
      let(:hotel_with_city){FactoryGirl.build(:hotel)}
      it 'should be valid' do
        expect(hotel_with_city).to be_valid
      end
    end
    context 'hotel without a name' do
      it 'should be invalid' do
        expect(Hotel.new).to be_invalid
      end
    end
    context 'hotel without a city' do
      let(:hotel_without_city){FactoryGirl.build(:hotel, :without_city)}
      it 'should be invalid' do
        expect(hotel_without_city).to be_invalid
      end
    end
    context 'hotel with a name that already exists from the same city' do
      let(:second_hotel){FactoryGirl.build(:hotel, name: "Hotel A", city: city_a)}
      before :each do
        FactoryGirl.create(:hotel,name: "Hotel A", city: city_a)
      end
      it 'should be invalid' do
        expect(second_hotel).to be_invalid
      end
    end
    context 'hotel with a name that already exists from a different city' do
      let(:second_hotel){FactoryGirl.build(:hotel, name: "Hotel B", city: city_a)}
      it 'should be valid' do
        expect(second_hotel).to be_valid
      end
    end
  end

  describe 'Scopes' do
    describe '.by_city_or_hotel' do

    end
    describe '.available_from' do

    end
    describe '.available_until' do

    end
    describe '.available_from_until' do

    end
  end
end
