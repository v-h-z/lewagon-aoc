# frozen_string_literal: true

class CitiesController < ApplicationController
  def show
    @city = City.find_by_slug(params[:slug]) # rubocop:disable Rails/DynamicFindBy
  end
end