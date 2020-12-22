require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  let(:test_url) { create(:shortened_url) }

  describe '#valid' do
    context 'with all attributes' do
      it 'should be true if original_url and token does not exists yet' do
        shortened_url = ShortenedUrl.new(original_url: 'www.google.com', token: 'a1b2c3')
        expect(shortened_url).to be_valid
      end

      it 'should be false if original_url already exists' do
        shortened_url = ShortenedUrl.new(original_url: test_url.original_url, token: 'a1b2c3')
        expect(shortened_url).not_to be_valid
      end

      it 'should be false if token already exists' do
        shortened_url = ShortenedUrl.new(original_url: 'www.google.com', token: test_url.token)
        expect(shortened_url).not_to be_valid
      end
    end

    context 'with missing attributes' do
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
end
