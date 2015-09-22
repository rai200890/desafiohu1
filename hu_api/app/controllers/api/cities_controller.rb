module Api
  class CitiesController < ApplicationController
    respond_to :json

    has_scope :by_city_name, allow_blank: false
    has_scope :by_id_or_city_id
    has_scope :per
    has_scope :page

    def index
      @cities = apply_scopes(City.page(1).per(15))
      respond_with(@cities)
    end

  end
end