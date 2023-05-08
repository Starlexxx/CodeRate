# frozen_string_literal: true

class RemoteCodeCompiler
  LANGUAGES = %w[
    PYTHON C CPP JAVA GO CS KOTLIN SCALA RUST RUBY HASKELL
  ].freeze

  MAX_MEMORY_LIMIT = 10_000
  MAX_TIME_LIMIT = 15
  API_COMPILE_URL = 'http://localhost:8080/api/compile/json'

  DEFAULT_HEADERS = {
    'Content-Type': 'application/json',
    'Accept-Encoding': 'application/json'
  }.freeze

  EMPTY_TEST_CASE = {
    test0: {
      expectedOutput: 'empty_test',
      input: ''
    }
  }.freeze

  attr_reader :raw_params

  class << self
    def call(raw_params)
      new(raw_params).compile
    end
  end

  def initialize(raw_params)
    @raw_params = raw_params
    @raw_params[:memory_limit] ||= MAX_MEMORY_LIMIT
    @raw_params[:time_limit] ||= MAX_TIME_LIMIT
  end

  def compile
    send_compiler_request(API_COMPILE_URL, request_options)
  end

  private

  def send_compiler_request(url, options)
    request = Typhoeus::Request.new(url, options)
    response = request.run

    JSON.parse(response.body).deep_symbolize_keys if response.success?
  end

  def request_options
    {
      method: :post,
      headers: DEFAULT_HEADERS,
      body: compiler_params(raw_params),
    }
  end

  def compiler_params(raw_params)
    {
      language: raw_params[:language],
      input: raw_params[:input],
      sourcecode: raw_params[:source_code],
      testCases: compiler_test_cases,
      timeLimit: raw_params[:time_limit],
      memoryLimit: raw_params[:memory_limit]
    }.compact.to_json
  end

  def compiler_test_cases
    return EMPTY_TEST_CASE if no_tests_needed?

    inputs = raw_params[:inputs].split('; ')
    outputs = tests(inputs.count).split('; ')
    test_cases = {}

    inputs.each_index do |i|
      test_cases[:"test#{i}"] = {
        expectedOutput: outputs[i],
        input: inputs[i]
      }
    end

    test_cases
  end

  def no_tests_needed?
    raw_params[:source] == :compiler_controller && raw_params[:inputs].blank?
  end

  def tests(tests_amount)
    raw_params[:tests] || 'empty_test; ' * tests_amount
  end
end
