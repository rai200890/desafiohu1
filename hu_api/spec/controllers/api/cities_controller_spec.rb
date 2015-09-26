require 'rails_helper'

RSpec.describe Api::CitiesController, type: :controller do
  render_views
  describe 'Cities API' do
    let(:city){FactoryGirl.create(:city)}
    before(:each){city}
    describe '.index' do
      it 'response is a success' do
        get :index, format: :json
        expect(response).to be_success
      end
      it 'returns in the right format' do
        get :index, format: :json
        parsed_body = JSON.parse(response.body)
        expect(parsed_body[0]).to include({"id" => city.id,"name" => city.name})
      end
    end
  end
end
