require 'rails_helper'

describe Api::V1::ShortenedUrlsController, type: :controller do
  let!(:url_test) { 'http://www.teste.com/' }

  describe 'POST create' do
    before do
      allow(SecureRandom).to receive(:hex).and_return('80e1df8d')
    end

    it 'creates a new ShortenedUrl' do
      expect {
        post :create, params: { shortened_url: { url: url_test } }
      }.to change { ShortenedUrl.count }.by(1)
    end

    it 'returns ShortenedUrl' do
      post :create, params: { shortened_url: { url: url_test } }
      expect(response.body).to eq('http://localhost:3000/80e1df8d')
    end

    it 'calls ShortenUrlService' do
      shorten_url_service = instance_double(ShortenUrlService)

      expect(ShortenUrlService).to receive(:new).with(url_test).and_return(shorten_url_service)
      expect(shorten_url_service).to receive(:call)

      post :create, params: { shortened_url: { url: url_test } }
    end

    it 'returns status 201 (created)' do
      post :create, params: { shortened_url: { url: url_test } }
      expect(response.status).to eq(201)
    end
  end

  describe 'GET show' do
    context 'with existing token' do
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

    context 'with a non existing token' do
      let(:token) { 'abbh34' }

      it 'returns not found error' do
        get :show, params: { token: token }

        json_reponse = JSON.parse(response.body)

        expect(json_reponse).to eq("Couldn't find ShortenedUrl")
      end

      it 'returns status 404 (not_found)' do
        get :show, params: { token: token }
        expect(response.status).to eq(404)
      end
    end
  end
end
