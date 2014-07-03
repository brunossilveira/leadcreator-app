class HomeController < ApplicationController
  def index
    @credential = has_credential? if current_user
  end
end
