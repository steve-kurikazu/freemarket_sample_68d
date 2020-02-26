class HomeController < ApplicationController
  def index
    @images = Image.all
    @items = Item.all
  end
end
