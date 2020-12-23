class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(e)
    render json: e, status: :not_found
  end
end
