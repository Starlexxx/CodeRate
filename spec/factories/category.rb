FactoryBot.define do
  factory :category do
    name { Faker::ProgrammingLanguage.name }
  end
end
