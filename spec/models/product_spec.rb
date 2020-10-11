require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { create(:product) }

  describe '#reserved_items_count' do
    let(:from) { DateTime.parse('2020-09-03 09:00:00') }
    let(:till) { DateTime.parse('2020-09-08 19:00:00') }

    let(:item) { create(:item, product: product) }

    let!(:existing_booking_past) do
      create(
        :booking,
        item: item,
        rental_start: from - 1.month,
        rental_end: from - 20.days
      )
    end

    let!(:existing_booking_future) do
      create(
        :booking,
        item: item,
        rental_start: from + 1.month,
        rental_end: from + 35.days
      )
    end

    context 'when existing bookings do not overlap with given rental period' do
      it 'reserved items count is 0' do
        expect(subject.reserved_items_count(from, till)).to eq(0)
      end
    end

    context 'when existing bookings overlap with given rental period' do
      context 'when existing booking ends exactly at start of given rental period' do
        before do
          create(
            :booking,
            item: item,
            rental_start: from - 2.hours,
            rental_end: from
          )
        end

        it 'reserved items count is 1' do
          expect(subject.reserved_items_count(from, till)).to eq(1)
        end
      end

      context 'when existing booking starts exactly at end of given rental period' do
        before do
          create(
            :booking,
            item: item,
            rental_start: till,
            rental_end: till + 2.days
          )
        end

        it 'reserved items count is 1' do
          expect(subject.reserved_items_count(from, till)).to eq(1)
        end
      end

      context 'when existing booking starts in the middle of given rental period' do
        before do
          create(
            :booking,
            item: item,
            rental_start: from + 2.days,
            rental_end: till - 1.day
          )
        end

        it 'reserved items count is 1' do
          expect(subject.reserved_items_count(from, till)).to eq(1)
        end
      end

      context 'when the same item was reserved twice' do
        before do
          create(
            :booking,
            item: item,
            rental_start: from + 2.days,
            rental_end: till - 1.day
          )

          create(
            :booking,
            item: item,
            rental_start: from + 4.days,
            rental_end: till - 1.day
          )
        end

        it 'returns 1' do
          expect(subject.reserved_items_count(from, till)).to eq(1)
        end
      end

      context 'when first item was reserved twice, second - once' do
        before do
          create(
            :booking,
            item: item,
            rental_start: from + 2.days,
            rental_end: till - 1.day
          )

          create(
            :booking,
            item: item,
            rental_start: from + 4.days,
            rental_end: till - 1.day
          )

          create(
            :booking,
            item: create(:item, product: product),
            rental_start: from + 4.days,
            rental_end: till - 1.day
          )
        end

        it 'returns 2' do
          expect(subject.reserved_items_count(from, till)).to eq(2)
        end
      end
    end
  end
end
