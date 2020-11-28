class ApplicationController < ActionController::API
  # how to get exceptions message and put them in json?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def healthcheck
    database_status = check_database_connection!
    status = 500 if [:error, :fail].include?(database_status[:status])
    render json: { database: database_status }, status: status || 200
  end

  private

  def record_not_found
    render json: { message: 'Not Found' }, status: 404
  end

  def record_invalid
    render json: { message: 'Unprocessable Entity' }, status: 422
  end

  def check_database_connection!
    start = Time.now
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection
    return { message: 'Database Connection Success', duration: (Time.now - start).to_f, status: :success } if ActiveRecord::Base.connected?
    { message: 'Database Connection Failed', duration: (Time.now - start).to_f, status: :fail }
  rescue
    { message: 'Database Connection Failed', duration: (Time.now - start).to_f, status: :error }
  end
end
