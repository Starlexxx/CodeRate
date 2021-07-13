class Task < ApplicationRecord
  validates :title, :body, presence: true
  mount_uploader :picture, PictureUploader
end
