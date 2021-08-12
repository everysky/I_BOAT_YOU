class PagesController < ApplicationController
  def home
    @boats = Boat.all.limit(3)
  end
end
