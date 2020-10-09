require 'rails_helper'

describe "get available products count", type: :request do
  let(:from) { DateTime.parse('2020-10-01 09:00:00') }
  let(:till) { DateTime.parse('2020-10-07 17:00:00') }

  let(:first_product) { create(:product, id: 1000, name: 'first_product') }
  let(:second_product) { create(:product, id: 1001, name: 'second_product') }

  let(:item_1_1) { create(:item, product: first_product) }
  let(:item_1_2) { create(:item, product: first_product) }
  let(:item_1_3) { create(:item, product: first_product) }

  let(:item_2_1) { create(:item, product: second_product) }
  let(:item_2_2) { create(:item, product: second_product) }
  let(:item_2_3) { create(:item, product: second_product) }

  let(:user) { create(:user) }
  let(:result) { [{"product_id"=>1000, "available"=>2, "total"=>3}, {"product_id"=>1001, "available"=>1, "total"=>3}] }

  before do
    create(
      :booking,
      user: user,
      rental_start: DateTime.parse('2020-09-01 09:00:00'),
      rental_end: DateTime.parse('2020-09-07 19:00:00'),
      item: item_1_1
    )

    create(
      :booking,
      user: user,
      rental_start: DateTime.parse('2020-09-20 09:00:00'),
      rental_end: DateTime.parse('2020-09-24 19:00:00'),
      item: item_1_2
    )

    create(
      :booking,
      user: user,
      rental_start: DateTime.parse('2020-09-29 09:00:00'),
      rental_end: DateTime.parse('2020-10-03 19:00:00'),
      item: item_1_3
    )

    create(
      :booking,
      user: user,
      rental_start: DateTime.parse('2020-10-03 09:00:00'),
      rental_end: DateTime.parse('2020-10-06 19:00:00'),
      item: item_2_1
    )

    create(
      :booking,
      user: user,
      rental_start: DateTime.parse('2020-10-07 08:00:00'),
      rental_end: DateTime.parse('2020-10-15 19:00:00'),
      item: item_2_2
    )

    get "/available_items/#{from}/#{till}"
  end


  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns all available products' do
    expect(JSON.parse(response.body)).to eq(result)
  end
end
