class ShortenedUrl < ApplicationRecord
  validates :original_url, :token, presence: true, uniqueness: true
end
