require 'rails_helper'

describe 'ユーザーログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user, post_image_id: '123') }
  let!(:other_post) { create(:post, user: other_user, post_image_id: '123') }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  context 'サイドバー表示の確認' do
    it 'ユーザー名と紹介文が表示される' do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
    end
    it '自分のユーザー情報編集画面へのリンクが存在する' do
      expect(page).to have_link '', href: edit_user_path(user)
    end
  end

describe '投稿一覧画面のテスト' do
  before do
    visit posts_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/posts'
    end
    it '自分の投稿と他人の投稿の空いとるのリンク先がそれぞれ正しい' do
      expect(page).to have_link post.title, href: posts_path(post)
      expect(page).to have_link other_post.title, href: posts_path(other_post)
    end
    it '自分の投稿と他人の投稿の内容が表示される' do
      expect(page).to have_content post.body
      expect(page).to have_content other_post.body
    end
  end

  context 'サイドバーの確認' do
    it '自分のユーザー名と紹介文が表示される' do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
    end
    it '自分のユーザ編集画面へのリンクが存在する' do
      expect(page).to have_link '', href: edit_user_path(user)
    end
    it '新規投稿画面へのリンクが存在する' do
      expect(page).to have_link '', href: new_post_path
    end
  end

  context '投稿のテスト：成功' do
    before do
      fill_in 'post[:title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'post[:body]', with: Faker::Lorem.characters(number: 20)
    end
    it '自分の新しい投稿が正しく保存される' do
      expect { click_button '新規投稿' }.to change(user.posts, :count).by(1)
    end
    it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
      click_button '新規投稿'
      expect(current_path).to eq '/posts' + Post.last.id.to_s
    end
  end




  describe 'ユーザー一覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users'
      end
      it '自分と他人のユーザー名が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content other_user.name
      end
      it  '自分と他人の紹介文が表示される' do
        expect(page).to have_content user.introduction
        expect(page).to have_content other_user.introduction
      end
      it '自分と他人のユーザー詳細へのリンク(投稿を見る)が表示される' do
        expect(page).to have_link '投稿を見る', href: user_path(user)
        expect(page).to have_link '投稿を見る', href: user_path(other_user)
      end
    end
  end
end
end