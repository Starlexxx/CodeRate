require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let_it_be(:task) { create(:task) }

  describe '#index' do
    it 'returns tasks' do
      get :index
      expect(response).to be_successful
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe '#show' do
    it 'returns task' do
      get :show, params: { id: task.id }
      expect(response).to be_successful
      expect(assigns(:task)).to eq(task)
    end
  end

  describe '#test_code' do
    let(:params) { { language: 'RUBY', source_code: 'puts gets', inputs: task.tests, results: task.results } }

    it 'returns response' do
      post :test_code, params: params
      expect(response).to be_successful
      expect(assigns(:response)).to be_present
    end
  end
end
