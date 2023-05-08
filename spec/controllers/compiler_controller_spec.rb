require 'rails_helper'

RSpec.describe CompilerController, type: :controller do
  describe '#execute' do
    before { get :execute }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template(:execute) }
  end

  describe '#submit_code' do
    let(:params) do
      {
        language: 'RUBY',
        source_code: 'puts gets',
        inputs: 'Hello World!',
        time_limit: 1,
        memory_limit: 64
      }
    end

    before { post :submit_code, params: params }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template(:submit_code) }
  end
end
