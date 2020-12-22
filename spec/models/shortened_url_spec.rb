require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  describe '#valid' do
    it 'should be true with all attributes' do
      shortened_url = ShortenedUrl.new(original_url: 'www.google.com', token: 'a1b2c3')
      expect(shortened_url).to be_valid
    end

    it 'should be false without original_url' do
      shortened_url = ShortenedUrl.new(token: 'a1b2c3')
      expect(shortened_url).not_to be_valid
    end

    it 'should be false without token' do
      shortened_url = ShortenedUrl.new(original_url: 'www.google.com')
      expect(shortened_url).not_to be_valid
    end
  end
end
