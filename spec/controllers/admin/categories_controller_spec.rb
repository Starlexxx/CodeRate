require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let_it_be(:category) { create(:category) }
  let_it_be(:user) { create(:user) }
  let_it_be(:admin) { create(:admin) }

  describe '#index' do
    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns categories' do
        get :index
        expect(response).to be_successful
        expect(assigns(:categories)).to eq([category])
      end
    end
  end

  describe '#new' do
    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns new category' do
        get :new
        expect(response).to be_successful
        expect(assigns(:category)).to be_a_new(Category)
      end
    end
  end

  describe '#create' do
    let(:params) { { category: { name: 'Ruby on Rails', parent_id: category.id } } }

    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        post :create, params: params
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'creates category' do
        expect { post :create, params: params }.to change(Category, :count).by(1)
        expect(response).to redirect_to(admin_categories_path)
      end
    end
  end

  describe '#edit' do
    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        get :edit, params: { id: category.id }
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns edit category' do
        get :edit, params: { id: category.id }
        expect(response).to be_successful
        expect(assigns(:category)).to eq(category)
      end
    end
  end

  describe '#update' do
    let(:params) { { id: category.id, category: { name: 'Go' } } }

    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        patch :update, params: params
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'updates category' do
        patch :update, params: params
        expect(response).to redirect_to(admin_categories_path)
      end
    end
  end

  describe '#destroy' do
    let_it_be(:category) { create(:category, parent_id: category.id) }
    let(:params) { { id: category.id } }

    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        delete :destroy, params: params
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'destroys category' do
        expect { delete :destroy, params: params }.to change(Category, :count).by(-1)
        expect(response).to redirect_to(admin_categories_path)
      end
    end
  end
end
