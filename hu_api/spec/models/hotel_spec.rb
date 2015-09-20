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
    let(:city){ FactoryGirl.create(:city, name: 'City') }
    let(:hotel) { FactoryGirl.create(:hotel, city: city)}
    describe '.by_city_or_hotel' do
      context 'city name that matches of one that exists with different case' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel("CITY")).to include(hotel)
        end
      end
      context 'city name that partially matches the start of the name of one that exists' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel("CI")).to include(hotel)
        end
      end
      context 'city name that partially matches the end of the name of one that exists' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel("TY")).to include(hotel)
        end
      end
      context 'hotel name that partially matches the start of the name of one that exists' do
        let(:hotel) { FactoryGirl.create(:hotel, name: "Hotel")}
        before :each do
          hotel
        end
        it 'should include that hotel' do
          expect(Hotel.by_city_or_hotel("HO")).to include(hotel)
        end
      end
      context 'hotel name that partially matches the end of the name of one that exists' do
        let(:hotel) { FactoryGirl.create(:hotel, name: "Hotel")}
        before :each do
          hotel
        end
        it 'should include that hotel' do
          expect(Hotel.by_city_or_hotel("tel")).to include(hotel)
        end
      end
      context 'city name that exists' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel("City")).to include(hotel)
        end
      end
      context 'city name that doesn\'t exists' do
        it 'should return empty' do
          expect(Hotel.by_city_or_hotel("Melbourne")).to be_empty
        end
      end
      context 'hotel name that exists' do
        let(:hotel){FactoryGirl.create(:hotel, name: 'Hotel1')}
        before :each do
          hotel
        end
        it 'should include the hotel' do
          expect(Hotel.by_city_or_hotel("Hotel1")).to include(hotel)
        end
      end
      context 'hotel name that doesn\'t exists' do
        it 'should return empty' do
          expect(Hotel.by_city_or_hotel("Hotel")).to be_empty
        end
      end
    end
    describe '.available_from' do
      context 'hotel with availability after the given start_date' do
        it 'should return that hotel' do
          pending
        end
      end
      context 'hotel with no availability' do
        before :each do
          hotel
        end
        it 'should return empty' do
          expect(Hotel.available_from(Date.today)).to be_empty
        end
      end
      context 'hotel with availability in the start_date' do
        it 'should return that hotel' do
          pending
        end
      end
    end
    describe '.available_until' do
      context 'hotel with availability before the given end_date' do
        it 'should return that hotel' do
          pending
        end
      end
      context 'hotel with no availability' do
        before :each do
          hotel
        end
        it 'should return empty' do
          expect(Hotel.available_until(Date.tomorrow)).to be_empty
        end
      end
    end
    describe '.available_from_until' do
      it '' do

      end
    end
  end
end
