class StatusesController < ApplicationController
  before_action :general_status, only: [:index]

  def index
    http_status = %i[error warning].include?(@status) ? :internal_server_error : :ok
    render json: { status: @status, services: services_status }, status: http_status
  end

  private

  # when all services is operational, status is operational
  # when one service is not operational, status is warning
  # when all services is not operational, status is error
  def general_status
    @database_status ||= DatabaseService.status
    @status = @database_status
  end

  def services_status
    { database: @database_status }
  end
end
