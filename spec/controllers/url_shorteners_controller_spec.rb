require 'rails_helper'

describe Api::V1::UrlShortenersController, type: :controller do
  let!(:url_test) { 'http://www.teste.com/' }

  describe 'POST create' do
    before do
      allow(SecureRandom).to receive(:hex).and_return('80e1df8d')
    end

    it 'creates a new ShortenedUrl' do
      expect {
        post :create, params: { url: url_test }
      }.to change { ShortenedUrl.count }.by(1)
    end

    it 'returns ShortenedUrl' do
      post :create, params: { url: url_test }
      expect(response.body).to eq('http://localhost:3000/80e1df8d')
    end

    it 'calls UrlShortenerService' do
      expect(UrlShortenerService).to receive(:short).with(url_test)
      post :create, params: { url: url_test }
    end

    it 'returns status 201 (created)' do
      post :create, params: { url: url_test }
      expect(response.status).to eq(201)
    end
  end

  describe 'GET show' do
    let(:token) { '242572b9' }

    before do
      ShortenedUrl.create!(original_url: url_test, token: token)
    end

    it 'returns the original_url' do
      get :show, params: { token: token }
      expect(response.body).to eq(url_test)
    end

    it 'returns status 200 (success)' do
      get :show, params: { token: token }
      expect(response.status).to eq(200)
    end
  end
end
