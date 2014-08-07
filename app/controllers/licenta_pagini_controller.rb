class LicentaPaginiController < ApplicationController
  def licentaHome
  	@u = current_user
  end
end
