require 'spec_helper'

require './app/models/calculator'

describe Calculator do
  let(:calculator) { described_class.new(started_at, ended_at) }

  describe '#worktime' do
    subject { calculator.worktime }

    context '出勤時間が 9:00 の場合' do
      let(:started_at) { "2018-12-25T09:00:00+09:00" }

      context '退勤時間が 15:00 の場合' do
        let(:ended_at) { "2018-12-25T15:00:00+09:00" }

        it { is_expected.to eq(6 * 60) }
      end

      context '退勤時間が 15:30 の場合' do
        let(:ended_at) { "2018-12-25T15:30:00+09:00" }

        it { is_expected.to eq(5 * 60 + 30) }
      end

      context '退勤時間が 18:00 の場合' do
        let(:ended_at) { "2018-12-25T18:00:00+09:00" }

        it { is_expected.to eq(8 * 60) }
      end

      context '退勤時間が 18:30 の場合' do
        let(:ended_at) { "2018-12-25T18:30:00+09:00" }

        it { is_expected.to eq(8 * 60) }
      end
    end
  end

  describe '#overtime' do
    subject { calculator.overtime }

    context '出勤時間が 9:00 の場合' do
      let(:started_at) { "2018-12-25T09:00:00+09:00" }

      context '退勤時間が 17:30 の場合' do
        let(:ended_at) { "2018-12-25T17:30:00+09:00" }

        it { is_expected.to eq(0) }
      end

      context '退勤時間が 18:00 の場合' do
        let(:ended_at) { "2018-12-25T18:00:00+09:00" }

        it { is_expected.to eq(0) }
      end

      context '退勤時間が 18:30 の場合' do
        let(:ended_at) { "2018-12-25T18:30:00+09:00" }

        it { is_expected.to eq(0) }
      end

      context '退勤時間が 19:00 の場合' do
        let(:ended_at) { "2018-12-25T19:00:00+09:00" }

        it { is_expected.to eq(30) }
      end

      context '退勤時間が 22:00 の場合' do
        let(:ended_at) { "2018-12-25T22:00:00+09:00" }

        it { is_expected.to eq(3 * 60 + 30) }
      end

      context '退勤時間が 22:30 の場合' do
        let(:ended_at) { "2018-12-25T22:30:00+09:00" }

        it { is_expected.to eq(3 * 60 + 30) }
      end

      context '退勤時間が 29:30 の場合' do
        let(:ended_at) { "2018-12-26T05:30:00+09:00" }

        it { is_expected.to eq(10 * 60 + 30) }
      end

      context '退勤時間が 30:00 の場合' do
        let(:ended_at) { "2018-12-26T06:00:00+09:00" }

        it { is_expected.to eq(10 * 60 + 30) }
      end
    end
  end

  describe '#ratetime' do
    subject { calculator.ratetime }

    context '退勤時間が 22:30 の場合' do
      let(:ended_at) { "2018-12-25T22:30:00+09:00" }

      context '出勤時間が 9:00 の場合' do
        let(:started_at) { "2018-12-25T09:00:00+09:00" }

        it { is_expected.to eq(0) }
      end

      context '出勤時間が 13:00 の場合' do
        let(:started_at) { "2018-12-25T13:00:00+09:00" }

        it { is_expected.to eq(0) }
      end

      context '出勤時間が 13:30 の場合' do
        let(:started_at) { "2018-12-25T13:30:00+09:00" }

        it { is_expected.to eq(30) }
      end
    end

    context '出勤時間が 13:00 の場合' do
      let(:started_at) { "2018-12-25T13:00:00+09:00" }

      context '退勤時間が 26:00 の場合' do
        let(:ended_at) { "2018-12-26T02:00:00+09:00" }

        it { is_expected.to eq(3 * 60 + 30) }
      end

      context '出勤時間が 26:30 の場合' do
        let(:ended_at) { "2018-12-26T02:30:00+09:00" }

        it { is_expected.to eq(3 * 60 + 30) }
      end
    end
  end
end
