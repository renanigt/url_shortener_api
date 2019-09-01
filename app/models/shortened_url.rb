class ShortenedUrl < ApplicationRecord
  validates_presence_of :original_url, :token
end
