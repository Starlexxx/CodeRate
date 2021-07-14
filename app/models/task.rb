class Task < ApplicationRecord
  validates :title, :body, presence: true
  mount_uploader :picture, PictureUploader
  has_rich_text :body
end
