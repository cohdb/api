FactoryBot.define do
  factory :user do
    provider 'steam'
    uid Faker::Number.number(17).to_s
    name Faker::ParksAndRec.character
  end
end
