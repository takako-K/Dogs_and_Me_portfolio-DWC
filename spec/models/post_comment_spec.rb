# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end

  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:user) { create(:user) }
    #
    let!(:post_comment) { build(:post_comment, user_id: user.id, post_id: post.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        post_comment.comment = ''
        is_expected.to eq false
      end
      it '200文字以下であること：200文字はOK' do
        post_comment.comment Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること：201文字はNG' do
        post_comment.comment Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
end