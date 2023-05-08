FactoryBot.define do
  TEST_ARRAY = [Faker::Lorem.sentence, Faker::Lorem.sentence]

  factory :task do
    title { "#{Faker::ProgrammingLanguage.name} + Basics" }
    body { Faker::Lorem.paragraph }
    category { create(:category) }
    tests { TEST_ARRAY }
    results { TEST_ARRAY }
  end
end
