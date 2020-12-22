FactoryBot.define do
  factory :shortened_url do
    original_url { 'www.test.com' }
    token { SecureRandom.hex(3) }
  end
end