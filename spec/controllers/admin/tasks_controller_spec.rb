require 'rails_helper'

RSpec.describe Admin::TasksController, type: :controller do
  let_it_be(:task) { create(:task) }
  let_it_be(:user) { create(:user) }
  let_it_be(:admin) { create(:admin) }

  let(:task_params) {
    {
      task: {
        title: Faker::ProgrammingLanguage.name,
        category: create(:category),
        body: Faker::Lorem.paragraph,
        tests: [Faker::Lorem.sentence, Faker::Lorem.sentence],
        results: [Faker::Lorem.sentence, Faker::Lorem.sentence]
      }
    }
  }

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

      it 'returns new task' do
        get :new
        expect(response).to be_successful
        expect(assigns(:task)).to be_a_new(Task)
      end
    end
  end

  describe '#create' do
    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        post :create, params: task_params
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns new task' do
        post :create, params: task_params
        expect(response).to be_successful
        expect(assigns(:task)).to be_a_new(Task)
      end
    end
  end

  describe '#edit' do
    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        get :edit, params: { id: task.id }
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns edit task' do
        get :edit, params: { id: task.id }
        expect(response).to be_successful
        expect(assigns(:task)).to eq(task)
      end
    end
  end

  describe '#update' do
    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        patch :update, params: task_params.merge(id: task.id)
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns edit task' do
        patch :update, params: task_params.merge(id: task.id)
        expect(response).to redirect_to(task)
      end
    end
  end

  describe '#destroy' do
    context 'when user is not admin' do
      before { sign_in user }

      it 'returns root_path' do
        delete :destroy, params: { id: task.id }
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns edit task' do
        delete :destroy, params: { id: task.id }
        expect(response).to redirect_to(tasks_path)
      end
    end
  end
end
