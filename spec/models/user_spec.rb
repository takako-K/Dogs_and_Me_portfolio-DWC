# frozen_string_literal: true
require 'rails_helper'

Rspec.describe 'Userモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        except(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        except(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        except(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'Eventモデルとの関係' do
      it '1:Nとなっている' do
        except(User.reflect_on_association(:events).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        except(User.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { user.valid? }
    
    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }
  end
end
