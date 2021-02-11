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

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'post[title]', with: post.title
      end
      it 'body編集フォームが表示される' do
        expect(page).to have_field 'post[body]', with: post.body
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新'
      end
      it '投稿詳細リンクが表示される' do
        expect(page).to have_link '投稿詳細へ', href: post_path(post)
      end
      it '投稿一覧リンクが表示される' do
        expect(page).to have_link '投稿一覧へ', href: posts_path
      end
    end

    context '編集のテスト：成功' do
      before do
        @post_old_title = post.title
        @post_old_body = post.body
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 4)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 29)
        click_button '更新'
      end

      it 'titleが正しく更新される' do
        expect(post.reload.title).not_to eq @post_old_title
      end
      it 'bodyが正しく更新される' do
        expect(post.reload.body).not_to eq @post_old_body
      end
      it 'リダイレクト先が更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/posts/' + post.id.to_s
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
  end

  describe '自分のユーザー詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧に自分の投稿のtitleが表示され、リンク先も正しい' do
        expect(page).to have_link post.title, href: post_path(post)
      end
      it '投稿一覧に自分の投稿のbodyが表示される' do
        expect(page).to have_content post.body
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_content other_post.title
        expect(page).not_to have_content other_post.body
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
  end

  describe '自分のユーザー情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it 'ユーザー名編集フォームに自分のユーザー名が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '紹介文編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新'
      end
    end

    context '更新のテスト：成功' do
      before do
        @user_old_name = user.name
        @user_old_introduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '更新'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_introduction
      end
      it 'リダイレクト先が自分のユーザー詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end