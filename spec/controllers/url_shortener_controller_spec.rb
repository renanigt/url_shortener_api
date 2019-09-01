require 'rails_helper'

describe Api::V1::UrlShortenersController do
  let!(:url_test) { 'http://www.teste.com/' }

  describe 'POST create' do
    before do
      allow(SecureRandom).to receive(:hex).and_return('80e1df8d')
    end

    it 'returns shortened url' do
      post :create, params: { url: url_test }
      expect(response.body).to eq('http://localhost:3000/80e1df8d')
    end

    it 'returns status 201 (created)' do
      post :create, params: { url: url_test }
      expect(response.status).to eq(201)
    end
  end

  describe 'GET show' do
    before do
      ShortenedUrl.create!(original_url: url_test, token: '242572b9')
    end

    it 'redirects to original_url' do
      post :show, params: { token: '242572b9' }
      expect(response).to redirect_to(url_test)
    end
  end
end
