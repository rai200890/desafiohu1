module Api
  class HotelsController < ApplicationController
    include Paging
    respond_to :json

    has_scope :by_id
    has_scope :by_city_id
    has_scope :by_city_or_hotel_name
    has_scope :available_from_until, using: [:start_date, :end_date], type: :hash

    def index
      @hotels = apply_scopes(Hotel)
      define_pagination_headers(Hotel)
      respond_with(@hotels)
    end

  end
end