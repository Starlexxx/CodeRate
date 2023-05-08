require 'rails_helper'

RSpec.describe RemoteCodeCompiler, type: :service do
  let(:valid_params) { { source: :compiler_controller, language: 'RUBY', source_code: 'puts "Hello World!"' } }
  let(:invalid_params) { { source: :compiler_controller, language: 'RUBY', source_code: 'put "Hello World!"' } }

  describe '#call' do
    context 'with valid params' do
      subject { described_class.call(valid_params) }

      it 'returns success' do
        expect(subject[:statusCode]).to eq(200)
      end

      it 'returns output' do
        expect(subject.dig(:testCasesResult, :test0, :output)).to eq("Hello World!\n")
      end
    end

    context 'with invalid params' do
      subject { described_class.call(invalid_params) }

      it 'returns failure' do
        expect(subject[:statusCode]).to eq(600)
      end

      it 'returns output' do
        expect(subject.dig(:testCasesResult, :test0, :verdict)).to eq("Runtime Error")
      end
    end
  end
end
