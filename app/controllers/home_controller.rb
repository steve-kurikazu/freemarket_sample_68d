class HomeController < ApplicationController
  def index

    @images = Image.all
    @items = Item.all.order(id: "DESC")
    # t_table = Category.arel_table
    # @parents = Category.where(ancestry: nil).order(id: "ASC")
  end
end
