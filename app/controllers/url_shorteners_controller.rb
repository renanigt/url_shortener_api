class UrlShortenersController < ApplicationController
  def create
    render json: UrlShortener.short(url_shortener_params[:url])
  end

  def show
    redirect_to ShortenedUrl.find_by(token: url_shortener_params[:token]).original_url
  end

  private

  def url_shortener_params
    params.permit(:url, :token)
  end
end
