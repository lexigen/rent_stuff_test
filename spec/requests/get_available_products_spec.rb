require 'rails_helper'

RSpec.describe 'get available products overview for given time interval', type: :request do
  let(:from) { DateTime.parse('2020-10-01 09:00:00') }
  let(:till) { DateTime.parse('2020-10-07 17:00:00') }

  let(:user) { create(:user) }

  let(:first_product) { create(:product, id: 1001) }
  let(:second_product) { create(:product, id: 1002) }

  let(:item_1_1) { create(:item, product: first_product) }
  let(:item_1_2) { create(:item, product: first_product) }
  let(:item_1_3) { create(:item, product: first_product) }

  let(:item_2_1) { create(:item, product: second_product) }
  let(:item_2_2) { create(:item, product: second_product) }
  let(:item_2_3) { create(:item, product: second_product) }

  let(:result) do
    { 'data' => [
      { 'attributes' =>
        { 'available' => 2, 'total' => 3 }, 'id' => '1001', 'type' => 'product' },
      { 'attributes' => { 'available' => 1, 'total' => 3 }, 'id' => '1002', 'type' => 'product' }
    ] }
  end

  before do
    # bookings beyond given interval, for first_product
    create(
      :booking,
      user: user,
      rental_start: from - 1.month,
      rental_end: till - 1.month,
      item: item_1_1
    )

    create(
      :booking,
      user: user,
      rental_start: from + 10.days,
      rental_end: till + 2.weeks,
      item: item_1_2
    )

    # the only booking inside given interval, for first_product
    create(
      :booking,
      user: user,
      rental_start: from - 3.days,
      rental_end: till - 4.days,
      item: item_1_3
    )

    # 2 bookings inside given interval, for second_product
    create(
      :booking,
      user: user,
      rental_start: from - 2.days,
      rental_end: till - 1.day,
      item: item_2_1
    )

    create(
      :booking,
      user: user,
      rental_start: from - 6.days,
      rental_end: till + 8.days,
      item: item_2_2
    )

    get "/available_items/#{from}/#{till}"
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns data about available products' do
    expect(JSON.parse(response.body)).to eq(result)
  end

  context 'when input is invalid' do
    context 'when input parameters is a string not representating date' do
      before do
        get "/available_items/some_string/#{till}"
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error' do
        expect(JSON.parse(response.body)).to include('errors')
      end
    end

    context 'when till is earlier than from' do
      before do
        get "/available_items/#{till}/#{from}"
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error' do
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end
end
