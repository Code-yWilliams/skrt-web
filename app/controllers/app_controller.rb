class AppController < ApplicationController
  def index
    @user = User.new
  end
end
