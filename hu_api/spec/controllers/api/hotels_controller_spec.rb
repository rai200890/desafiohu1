require 'rails_helper'

RSpec.describe Api::HotelsController, type: :controller do
  render_views
  describe 'Hotels API' do
    let(:hotel){FactoryGirl.create(:hotel)}
    before(:each){hotel}
    describe '.index' do
      it 'response is a success' do
        get :index, format: :json
        expect(response).to be_success
      end
      it 'returns in the right format' do
        get :index, format: :json
        parsed_body = JSON.parse(response.body)
        expect(parsed_body[0]).to include({"id" => hotel.id,
                                             "name" => hotel.name,
                                             "city_id" => hotel.city.id,
                                             "city_name" => hotel.city.name
                                            })
      end
    end
  end
end
