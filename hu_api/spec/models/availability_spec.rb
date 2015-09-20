require 'rails_helper'

RSpec.describe Availability, type: :model do

  describe 'Validations' do
    let(:availability){FactoryGirl.build(:availability)}
    context 'with a hotel and a day' do
      it 'should be valid' do
        expect(availability).to be_valid
      end
    end
    context 'without a hotel and a day' do
      let(:availability){FactoryGirl.build(:availability, :without_hotel, :without_day)}
      it 'should be invalid' do
        expect(availability).to be_invalid
      end
    end
    context 'without a hotel and with a day' do
      let(:availability){FactoryGirl.build(:availability, :without_hotel, :with_day)}
      it 'should be invalid' do
        expect(availability).to be_invalid
      end
    end
    context 'without a day' do
      let(:availability){FactoryGirl.build(:availability, :without_day)}
      it 'should be invalid' do
        expect(availability).to be_invalid
      end
    end
    context 'with a day already associated with the same hotel' do
      let(:hotel) { FactoryGirl.create(:hotel) }
      let(:availability){FactoryGirl.build(:availability, day: '03/05/2015', hotel: hotel)}
      before :each do
        FactoryGirl.create(:availability, day: '03/05/2015', hotel: hotel)
      end
      it 'should be invalid' do
        expect(availability).to be_invalid
      end
    end
  end

end
