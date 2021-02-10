require 'rails_helper'

describe 'ユーザーログイン後のテスト', type: :system do
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
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link post.title, href: post_path(post)
        expect(page).to have_link other_post.title, href: post_path(other_post)
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
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 30)
      end
      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '新規投稿' }.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button '新規投稿'
        expect(current_path).to eq '/posts/' + Post.last.id.to_s
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it '投稿者（自分）のユーザー名が表示される' do
        expect(page).to have_content post.user.name
      end
      it '投稿のタイトルが表示される' do
        expect(page).to have_content post.title
      end
      it '投稿の内容が表示される' do
        expect(page).to have_content post.body
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_post_path(post)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: post_path(post)
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
        visit new_post_path
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 30)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '新規投稿' }.to change(user.post, :count).by(1)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集'
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end

      it '正しく削除される' do
        expect(Post.where(id: post.id).count).to eq 0
      end
      it 'リダイレクト先が投稿一覧画面になっている' do
        expect(current_path).to eq '/posts'
      end
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