# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login', type: :system do
  context 'Eメールとパスワードが正しく入力されたら' do
    scenario 'ログインに成功する' do
      FactoryBot.create(:user, email: 'tester@example.com', password: 'password')
      visit new_user_session_path

      fill_in 'Eメール', with: 'tester@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      aggregate_failures do
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'tester@example.com としてログイン中'
        expect(page).to have_current_path books_path
      end
    end
  end
end
