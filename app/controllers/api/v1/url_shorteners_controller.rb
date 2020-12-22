module Api
  module V1
    class UrlShortenersController < ApplicationController
      def create
        render json: UrlShortenerService.short(url_shortener_params[:url]), status: :created
      end

      def show
        render json: ShortenedUrl.find_by(token: url_shortener_params[:token]).original_url
      end

      private

      def url_shortener_params
        params.permit(:url, :token)
      end
    end
  end
end
