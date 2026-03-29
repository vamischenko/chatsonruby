FactoryBot.define do
  factory :room do
    name { Faker::Lorem.words(number: 2).join(" ") }
  end
end
