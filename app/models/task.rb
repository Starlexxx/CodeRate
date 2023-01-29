# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :category

  validates :title, :body, presence: true

  mount_uploader :picture, PictureUploader

  has_rich_text :body
end
