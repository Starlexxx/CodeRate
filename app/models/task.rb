class Task < ApplicationRecord
  mount_uploader :picture, PictureUploader
end
