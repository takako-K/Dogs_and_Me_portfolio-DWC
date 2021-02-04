# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end

  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'post_imageカラム' do
      it '空欄でないこと' do
        post.post_image = ''
        is_expected.to eq false
      end
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
      it '50文字以下であること：50文字はOK' do
        post.title = Faker::Lorem.characters(number: 50)      ###
        is_expected.to eq true
      end
      it '50文字以下であること：51文字はNG' do
        post.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ''
        is_expected.to eq false
      end
      it '300文字以下であること：300文字はOK' do              ###
        post.body = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下であること：301文字はNG' do
        post.body = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end
end