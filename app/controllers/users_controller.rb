class UsersController < ApplicationController
  def show
    @item = Item.find(1)
  end
end
