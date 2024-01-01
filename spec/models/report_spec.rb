# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  it '有効なファクトリを持つこと' do
    report = FactoryBot.build(:report)
    expect(report).to be_valid
  end

  describe '#editable?' do
    context '日報を作成したユーザーの場合' do
      it 'true を返すこと' do
        user = FactoryBot.create(:user)
        report = FactoryBot.create(:report, user:)
        expect(report.editable?(user)).to eq true
      end
    end

    context '日報を作成したユーザー以外の場合' do
      it 'false を返すこと' do
        user = FactoryBot.create(:user, name: 'author')
        report = FactoryBot.create(:report, user:)
        other_user = FactoryBot.create(:user, name: 'other')
        expect(report.editable?(other_user)).to eq false
      end
    end
  end

  describe '#created_on' do
    let(:report) { FactoryBot.create(:report, created_at: '2023-12-25 12:00:00') }

    it '日報の作成日を返すこと' do
      expect(report.created_on).to eq Date.parse('2023-12-25')
    end

    it '返す値は Date クラスのインスタンスであること' do
      expect(report.created_on.class).to eq Date
    end
  end
end
