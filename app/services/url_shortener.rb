class UrlShortener
  def initialize(original_url)
    @original_url = original_url
  end

  def call
    ShortenedUrl.create!(
      original_url: original_url,
      token: token
    ) unless already_exists?

    shorter
  end

  class << self
    def short(original_url)
      self.new(original_url).call
    end
  end

  private

    attr_reader :original_url

    def shorter
      "http://localhost:3000/#{token}"
    end

    def token
      ShortenedUrl.find_by(original_url: original_url)&.token || SecureRandom.hex(4)
    end

    def already_exists?
      ShortenedUrl.where(original_url: original_url).exists?
    end
end
