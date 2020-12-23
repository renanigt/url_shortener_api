module Api
  module V1
    class ShortenedUrlsController < ApplicationController
      def create
        render json: ShortenUrlService.new(url_shortener_params[:url]).call, status: :created
      end

      def show
        render json: ShortenedUrl.find_by!(token: params[:token]).original_url
      end

      private

      def url_shortener_params
        params.require(:shortened_url).permit(:url)
      end
    end
  end
end
