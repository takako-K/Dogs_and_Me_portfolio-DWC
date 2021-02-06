# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Eventモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Event.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end

  describe 'バリデーションのテスト' do
    subject { event valid? }

    let(:user) { create(:user) }
    let!(:event) { build(:event, user_id: user.id) }

    context 'startカラム' do
      it '空欄でないこと' do
        event.start = ''
        is_expected.to eq false
      end
    end

    context 'endカラム' do
      it '空欄でないこと' do
        event.end = ''
        is_expected.to eq false
      end
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        event.title = ''
        is_expected.to eq false
      end
      it '30文字以下であること：30文字はOK' do
        event.title = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '30文字以下であること：31文字はNG' do
        event.title = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        event.body = ''
        is_expected.to eq false
      end
      it '100文字以下であること：100文字はOK' do
        event.body = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること：101文字はNG' do
        event.body = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
end
