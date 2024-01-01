# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'Report Title' }
    content { 'content...' }
    association :user
  end
end
