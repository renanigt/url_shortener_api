module Api
  module V1
    class UrlShortenersController < ApplicationController
      def create
        render json: ShortenUrlService.new(url_shortener_params[:url]).call, status: :created
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
