# frozen_string_literal: true

class RemoteCodeCompiler
  LANGUAGES = %w[PYTHON C CPP JAVA GO CS KOTLIN SCALA RUST RUBY HASKELL].freeze
  EXTENSIONS = %w[py c cpp java go cs kt scala rs rb hs].freeze
  MAX_MEMORY_LIMIT = 10_000
  MAX_TIME_LIMIT = 15
  API_COMPILE_URL = 'http://localhost:8080/api/compile/json'

  attr_reader :params

  class << self
    def call(params)
      new(params).compile
    end
  end

  def initialize(params)
    @params = params
    params[:memory_limit] ||= MAX_MEMORY_LIMIT
    params[:time_limit] ||= MAX_TIME_LIMIT
  end

  def compile
    perform_request(API_COMPILE_URL, :post, compiler_params)
  end

  private

  def perform_request(url, method, compiler_params)
    options = { method: method, headers: default_headers }

    if method == :post
      options[:body] = compiler_params.to_json
    else
      options[:params] = compiler_params
    end

    request = Typhoeus::Request.new(url, options)
    response = request.run

    JSON.parse(response.body).deep_symbolize_keys if response.success?
  end

  def default_headers
    {
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/json'
    }
  end

  def compiler_params
    {
      language: params[:language],
      memoryLimit: params[:memory_limit],
      timeLimit: params[:time_limit],
      testCases: compiler_test_cases,
      sourcecode: params[:source_code]
    }.compact
  end

  def compiler_test_cases
    inputs = params[:inputs].split('; ')
    outputs = tests(inputs.count).split('; ')
    test_cases = {}

    inputs.each_index do |i|
      test_cases[:"test#{i}"] = { expectedOutput: outputs[i], input: inputs[i] }
    end

    test_cases
  end

  def tests(tests_amount)
    params[:tests] || 'empty_test; ' * tests_amount
  end

  def file(text, extension)
    return if text.blank?

    path = "#{Rails.root}/tmp/#{filename}.#{extension}"
    File.open(path, 'w') { |file| file.write(text) }

    File.open(path, 'r')
  end

  def filename
    random_string
  end

  def random_string
    @random_string ||= "#{SecureRandom.urlsafe_base64}"
  end

  def code_extension_by_language
    index = LANGUAGES.index(params[:language])

    EXTENSIONS[index]
  end
end
