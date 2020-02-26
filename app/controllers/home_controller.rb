class HomeController < ApplicationController
  def index
    t_table = Category.arel_table
    @parents = Category.where(ancestry: nil).order("id ASC")
  end
end
