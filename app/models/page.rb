class Page < ApplicationRecord
  validates :title, :slug, :url, :main_content, :secondary_content, :sidebar, presence: true
  validates :url, uniqueness: true
end
