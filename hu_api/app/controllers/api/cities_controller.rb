module Api
  class CitiesController < ApplicationController
    include Paging

    respond_to :json
    has_scope :by_city_name, allow_blank: false

    def index
      @cities = apply_scopes(City)
      define_pagination_headers(City)
      respond_with(@cities)
    end

  end
end