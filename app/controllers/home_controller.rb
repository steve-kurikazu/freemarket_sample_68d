class HomeController < ApplicationController
  def index
    t_table = Category.arel_table
    @parents = Category.where(t_table[:ancestry].eq(nil)).order("id ASC")
  end
end
