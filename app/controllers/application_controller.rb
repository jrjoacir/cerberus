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

  def paginate(elements)
    @total_elements = elements.count
    set_pagination_headers!
    elements.paginate(per_page: per_page, page: page)
  end

  def render_paginate(elements, status: 200)
    render json: paginate(elements), status: status
  rescue RangeError => e
    render json: { message: e.message }, status: 400
  end

  def page
    @page ||= (params[:page] || 1).to_i
  end

  def per_page
    @per_page ||= (params[:per_page] || @total_elements).to_i
  end

  def total_pages
    @total_pages ||= per_page.positive? ? (@total_elements.to_f / per_page).ceil : 0
  end

  def set_pagination_headers!
    headers['X-Per-Page'] = params[:per_page]
    headers['X-Page'] = params[:page]
    headers['X-Total-Pages'] = total_pages
    headers['X-Total-Elements'] = @total_elements
  end
end
