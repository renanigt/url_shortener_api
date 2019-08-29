class CreateShortenedUrl < ActiveRecord::Migration[6.0]
  def change
    create_table :shortened_urls do |t|
      t.string :original_url
      t.string :shortened_url

      t.timestamps
    end
  end
end
