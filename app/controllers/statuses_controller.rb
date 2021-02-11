class StatusesController < ApplicationController
  def index
    internal_server_error = :internal_server_error if %i[error fail].include?(database_status[:status])
    render json: { database: database_status }, status: internal_server_error || :ok
  end

  private

  def database_status
    start = Time.now
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection
    duration = (Time.now - start).to_f
    return render_database_connection_success(duration) if ActiveRecord::Base.connected?

    render_database_connection_fail(duration)
  rescue StandardError
    render_database_connection_error(duration)
  end

  def render_database_connection_success(duration)
    { message: 'Database Connection Success', duration: duration, status: :success }
  end

  def render_database_connection_fail(duration)
    { message: 'Database Connection Failed', duration: duration, status: :fail }
  end

  def render_database_connection_error(duration)
    { message: 'Database Connection Failed', duration: duration, status: :error }
  end
end
