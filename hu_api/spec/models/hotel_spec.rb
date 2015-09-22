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
    describe '.by_city_or_hotel_name' do
      context 'city name that matches of one that exists with different case' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel_name("CITY")).to include(hotel)
        end
      end
      context 'city name that partially matches the start of the name of one that exists' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel_name("CI")).to include(hotel)
        end
      end
      context 'city name that partially matches the end of the name of one that exists' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel_name("TY")).to include(hotel)
        end
      end
      context 'hotel name that partially matches the start of the name of one that exists' do
        let(:hotel) { FactoryGirl.create(:hotel, name: "Hotel")}
        before :each do
          hotel
        end
        it 'should include that hotel' do
          expect(Hotel.by_city_or_hotel_name("HO")).to include(hotel)
        end
      end
      context 'hotel name that partially matches the end of the name of one that exists' do
        let(:hotel) { FactoryGirl.create(:hotel, name: "Hotel")}
        before :each do
          hotel
        end
        it 'should include that hotel' do
          expect(Hotel.by_city_or_hotel_name("tel")).to include(hotel)
        end
      end
      context 'city name that exists' do
        before :each do
          hotel
        end
        it 'should include hotels from that city' do
          expect(Hotel.by_city_or_hotel_name("City")).to include(hotel)
        end
      end
      context 'city name that doesn\'t exists' do
        it 'should not include any hotel' do
          expect(Hotel.by_city_or_hotel_name("Melbourne")).not_to include(hotel)
        end
        context 'hotel name that exists' do
          let(:hotel){FactoryGirl.create(:hotel, name: 'Hotel1')}
          before :each do
            hotel
          end
          it 'should include the hotel' do
            expect(Hotel.by_city_or_hotel_name("Hotel1")).to include(hotel)
          end
        end
        context 'hotel name that doesn\'t exists' do
          it 'should not include that hotel' do
            expect(Hotel.by_city_or_hotel_name("Hofdgfdg")).not_to include(hotel)
          end
        end
      end
      describe '.available_from' do
        let(:hotel){FactoryGirl.create(:hotel)}
        context 'hotel with availability after the given start_date' do
          before(:each) do
            FactoryGirl.create(:availability, day: '09/05/2015' , hotel: hotel)
          end
          it 'should return that hotel' do
            expect(Hotel.available_from('10/05/2015')).to include(hotel)
          end
        end
        context 'hotel with no availability' do
          it 'should not include that hotel' do
            expect(Hotel.available_from('10/05/2015')).not_to include(hotel)
          end
        end
        context 'hotel with availability at the start_date' do
          before(:each) do
            FactoryGirl.create(:availability, day: '10/05/2015' , hotel: hotel)
          end
          it 'should return that hotel' do
            expect(Hotel.available_from('10/05/2015')).to include(hotel)
          end
        end
      end
      describe '.available_until' do
        let(:hotel){FactoryGirl.create(:hotel)}
        context 'hotel with availability before the given end_date' do
          before(:each) do
            FactoryGirl.create(:availability, day: '09/05/2015' , hotel: hotel)
          end
          it 'should return that hotel' do
            expect(Hotel.available_from('08/05/2015')).to include(hotel)
          end
        end
        context 'hotel with no availability' do
          before :each do
            hotel
          end
          it 'should not include that hotel' do
            expect(Hotel.available_until('08/04/2O15')).not_to include(hotel)
          end
        end
        context 'hotel with availability at the given end_date' do
          before(:each) do
            FactoryGirl.create(:availability, day: '09/05/2015' , hotel: hotel)
          end
          it 'should return that hotel' do
            expect(Hotel.available_from('09/05/2015')).to include(hotel)
          end
        end
      end
      describe '.available_from_until' do
        let(:hotel){FactoryGirl.create(:hotel)}
        context 'hotel with availability all days between given start_date and end_date' do
          before(:each) do
            FactoryGirl.create(:availability, day: '09/05/2015' , hotel: hotel)
            FactoryGirl.create(:availability, day: '10/05/2015' , hotel: hotel)
            FactoryGirl.create(:availability, day: '11/05/2015' , hotel: hotel)
          end
          it 'should return that hotel' do
            expect(Hotel.available_from_until('09/05/2015','11/05/2015')).to include(hotel)
          end
        end
        context 'hotel with availability some days between given start_date and end_date' do
          before(:each) do
            FactoryGirl.create(:availability, day: '09/05/2015' , hotel: hotel)
            FactoryGirl.create(:availability, day: '11/05/2015' , hotel: hotel)
          end
          it 'should not include that hotel' do
            expect(Hotel.available_from_until('09/05/2015','11/05/2015')).not_to include(hotel)
          end
        end
      end
      context 'hotel with availability more days between given start_date and end_date' do
        before(:each) do
          FactoryGirl.create(:availability, day: '09/05/2015' , hotel: hotel)
          FactoryGirl.create(:availability, day: '10/05/2015' , hotel: hotel)
          FactoryGirl.create(:availability, day: '11/05/2015' , hotel: hotel)
          FactoryGirl.create(:availability, day: '12/05/2015' , hotel: hotel)
        end
        it 'should return that hotel' do
          expect(Hotel.available_from_until('09/05/2015','11/05/2015')).to include(hotel)
        end
      end
    end
  end
end