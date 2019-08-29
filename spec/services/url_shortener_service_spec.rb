require 'rails_helper'

describe UrlShortenerService do
  describe '#call' do
    let!(:google_url) { 'https://www.google.com/' }

    context 'original_url is already shortened in database' do
      before do
        allow(SecureRandom).to receive(:hex).and_return('80e1df8d')
        @existing_shortened_url = shorter(google_url)
      end

      it 'does not save in database' do
        expect { shorter(google_url) }.not_to change { ShortenedUrl.count }
      end

      it 'returns existing shortened_url' do
        expect(shorter(google_url)).to eq('http://localhost:3000/80e1df8d')
      end
    end

    context 'original_url is not shortened in database' do
      before do
        allow(SecureRandom).to receive(:hex).and_return('242572b9')
      end

      it 'save new shortened url in database' do
        expect { shorter(google_url) }.to change { ShortenedUrl.count }
      end

      it 'return generated shortened url' do
        expect(shorter(google_url)).to eq('http://localhost:3000/242572b9')
      end
    end
  end

  def shorter(original_url)
    described_class.new(original_url).call
  end
end
