class ProductsController < ApplicationController
  def available
    available_products = Product.available(params[:from], params[:till])
    render json: available_products.as_json
  end
end
