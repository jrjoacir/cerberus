class ApplicationController < ActionController::API
  # how to get exceptions message and put them in json?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found
    render json: { message: 'Not Found' }, status: 404
  end

  def record_invalid
    render json: { message: 'Unprocessable Entity' }, status: 422
  end
end
