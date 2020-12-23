class ShortenUrlService
  BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:3000')

  def initialize(original_url)
    @original_url = original_url
  end

  def call
    @shortened_url = ShortenedUrl.find_or_create_by(original_url: original_url) do |shortened_url|
      shortened_url.token = SecureRandom.hex(4)
    end

    shorter
  end

  private

    attr_reader :original_url, :shortened_url

    def shorter
      "#{BASE_URL}/#{shortened_url.token}"
    end
end
