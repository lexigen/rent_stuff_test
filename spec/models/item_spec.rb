require 'rails_helper'

RSpec.describe Item, type: :model do
  subject(:item) { create(:item) }

  describe '#reserved?' do
    let(:from) { DateTime.parse('2020-09-03 09:00:00') }
    let(:till) { DateTime.parse('2020-09-08 19:00:00') }

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

    context 'existing bookings do not overlap with given rental period' do
      it 'returns false' do
        expect(subject.reserved?(from, till)).to be false
      end
    end

    context 'existing booking ends exactly at start of given rental period' do
      before do
        create(
          :booking,
          item: item,
          rental_start: from - 2.hours,
          rental_end: from
        )
      end

      it 'returns true' do
        expect(subject.reserved?(from, till)).to be true
      end
    end

    context 'existing booking starts exactly at end of given rental period' do
      before do
        create(
          :booking,
          item: item,
          rental_start: till,
          rental_end: till + 2.days
        )
      end

      it 'returns true' do
        expect(subject.reserved?(from, till)).to be true
      end
    end

    context 'existing booking starts in the middle of given rental period' do
      before do
        create(
          :booking,
          item: item,
          rental_start: from + 2.days,
          rental_end: till - 1.day
        )
      end

      it 'returns true' do
        expect(subject.reserved?(from, till)).to be true
      end
    end
  end
end
