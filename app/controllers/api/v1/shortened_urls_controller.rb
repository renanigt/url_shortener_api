module Api
  module V1
    class ShortenedUrlsController < ApplicationController
      before_action :set_shortened_url, only: [:show, :go]

      def create
        render json: ShortenUrlService.new(url_shortener_params[:url]).call, status: :created
      end

      def show
        render json: @shortened_url
      end

      def go
        redirect_to @shortened_url.original_url
      end

      private

      def url_shortener_params
        params.require(:shortened_url).permit(:url)
      end

      def set_shortened_url
        @shortened_url = ShortenedUrl.find_by!(token: params[:token])
      end
    end
  end
end
