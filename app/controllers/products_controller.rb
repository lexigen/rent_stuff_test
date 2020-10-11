class ProductsController < ApplicationController
  def available
    products = Product.includes(items: :bookings)
    render json: ProductSerializer.new(products, { params: { from: params[:from], till: params[:till] } })
  end
end
