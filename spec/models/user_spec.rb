# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効なファクトリを持っていること' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe '#name_or_email' do
    context '氏名が登録されている場合' do
      it '氏名を返す' do
        user = FactoryBot.create(:user, name: 'tester')
        expect(user.name_or_email).to eq 'tester'
      end
    end

    context '氏名が登録されていない場合' do
      it 'メールアドレスを返す' do
        user = FactoryBot.create(:user, name: nil, email: 'tester@example.com')
        expect(user.name_or_email).to eq 'tester@example.com'
      end
    end
  end
end
