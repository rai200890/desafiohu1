module Api
  class HotelsController < ApplicationController
    respond_to :json

    has_scope :by_city_or_hotel
    has_scope :available_from
    has_scope :available_until
    has_scope :available_from_until, using: [:start_date, :end_date], type: :hash
    has_scope :per
    has_scope :page

    def index
      respond_with(apply_scopes(Hotel.page(1)))
    end

  end
end