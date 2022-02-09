# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  def show
    @tasks = Task.where(category_id: [@category.subtree_ids]).paginate(page: params[:page], per_page: 5)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
