class ErrorsController < ApplicationController
  layout 'simple'

  allow_unauthenticated_access

  def not_found
    respond_to do |format|
      format.html
      format.json { render json: { error: "Resource not found" }, status: :not_found }
    end
  end
end
