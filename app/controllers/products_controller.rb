class ProductsController < ApplicationController
  def available
    time_interval = Validators::InputValidator.new(params).execute
    if time_interval.valid?
      products = Product.includes(items: :bookings)
      render json: ProductSerializer.new(products, { params: { from: time_interval.from, till: time_interval.till } })
    else
      render json: { message: 'Input validation failed', errors: time_interval.errors.full_messages, status: 400 },
             status: :bad_request
    end
  end
end
