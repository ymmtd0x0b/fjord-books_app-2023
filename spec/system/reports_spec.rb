# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:report) { FactoryBot.create(:report, user:) }

  scenario 'ユーザーは日報を作成する' do
    sign_in user
    visit new_report_path

    expect do
      fill_in 'タイトル', with: 'テスト日報のタイトル'
      fill_in '内容', with: 'テスト日報の内容'
      click_button '登録する'

      aggregate_failures do
        expect(page).to have_content '日報が作成されました。'
        expect(page).to have_content 'テスト日報のタイトル'
      end
    end.to change(user.reports, :count).by(1)
  end

  scenario 'ユーザーは日報を編集する' do
    sign_in user
    visit edit_report_path(report)

    fill_in 'タイトル', with: '更新後のタイトル', fill_options: { clear: :backspace }
    fill_in '内容', with: '更新後の内容', fill_options: { clear: :backspace }
    click_button '更新する'

    aggregate_failures do
      expect(page).to have_content '日報が更新されました。'
      expect(page).to have_content '更新後のタイトル'
      expect(page).to have_content '更新後の内容'
    end
  end

  scenario 'ユーザーは日報を削除する' do
    sign_in user
    visit report_path(report)

    expect do
      click_button 'この日報を削除'
      expect(page).to have_content '日報が削除されました。'
    end.to change(user.reports, :count).by(-1)
  end
end
