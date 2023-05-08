require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let_it_be(:category) { create(:category) }
  let_it_be(:user) { create(:user) }

  describe '#show' do
    it 'returns category' do
      get :show, params: { id: category.id }
      expect(response).to be_successful
      expect(assigns(:category)).to eq(category)
    end
  end
end
