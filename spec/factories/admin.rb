FactoryBot.define do
  factory :admin, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    type { 'Admin' }
    confirmed_at { Time.zone.now }
  end
end
