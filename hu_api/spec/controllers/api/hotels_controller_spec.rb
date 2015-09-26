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
      it 'includes pagination headers' do
        get :index, format: :json
        expect(response.headers["X-Pagination-Per-Page"]).to eq(15)
        expect(response.headers["X-Pagination-Current-Page"]).to eq(1)
        expect(response.headers["X-Pagination-Total-Pages"]).to eq(1)
        expect(response.headers["X-Pagination-Total-Entries"]).to eq(1)
      end
    end
  end
end
