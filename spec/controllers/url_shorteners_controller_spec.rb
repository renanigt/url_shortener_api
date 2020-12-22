require 'rails_helper'

describe Api::V1::UrlShortenersController, type: :controller do
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

    it 'returns the original_url' do
      get :show, params: { token: '242572b9' }
      expect(response.body).to eq(url_test)
    end

    it 'returns status 200 (success)' do
      get :show, params: { token: '242572b9' }
      expect(response.status).to eq(200)
    end
  end
end
