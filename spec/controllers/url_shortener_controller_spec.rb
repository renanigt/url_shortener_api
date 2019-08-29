require 'rails_helper'

describe UrlShortenersController do
  describe 'POST create' do
    before do
      allow(SecureRandom).to receive(:hex).and_return('80e1df8d')
    end

    it 'returns shortened url' do
      post :create, params: { url: 'www.teste.com/'}
      expect(response.body).to eq('http://localhost:3000/80e1df8d')
    end
  end

  describe 'GET show' do
    before do
      ShortenedUrl.create!(
        original_url: 'http://www.teste.com/',
        token: '242572b9'
      )
    end

    it 'redirects to original_url' do
      post :show, params: { token: '242572b9' }
      expect(response).to redirect_to('http://www.teste.com/')
    end
  end
end
