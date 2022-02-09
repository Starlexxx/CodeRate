# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: :show

  def index
    @tasks = Task.paginate(page: params[:page], per_page: 5)
  end

  def show
    # define access parameters
    endpoint = '0fa75163.compilers.sphere-engine.com'
    access_token = '6bf3291fc2e34e712d804efe8a198e11'

    # send request
    uri = URI.parse("http://#{endpoint}/api/v3/compilers?access_token=#{access_token}")
    http = Net::HTTP.new(uri.host, uri.port)

    begin
      response = http.request(Net::HTTP::Get.new(uri.request_uri))

      # process response
      case response
      when Net::HTTPSuccess
        arr = JSON.parse(response.body)['items']
      when Net::HTTPUnauthorized
        puts 'Invalid access token'
      end
    rescue StandardError => e
      render plain: 'Connection error'
    end

    @language_array = []

    arr.each do |i|
      @language_array << [i['name'], i['id']]
    end
  end

  def test_code
    @ret_view = 13
    @result = params['results']
    # Send the Post request
    uri = URI('http://0fa75163.compilers.sphere-engine.com/api/v3/submissions?access_token=6bf3291fc2e34e712d804efe8a198e11')
    uri.query = URI.encode_www_form({ 'access_token' => '6bf3291fc2e34e712d804efe8a198e11' })
    response = Net::HTTP.post_form(uri,
                                   { 'sourceCode' => params['sc'], 'compilerId' => params['Compiler'],
                                     'input' => params['testcase'] })

    returned_id = JSON.parse(response.body)['id'].to_s
    returned_status = -1

    p returned_id

    url = URI.parse("http://0fa75163.compilers.sphere-engine.com/api/v3/submissions/#{returned_id}?access_token=6bf3291fc2e34e712d804efe8a198e11")
    req = Net::HTTP::Get.new(url.to_s)
    url.query = URI.encode_www_form({ 'access_token' => '6bf3291fc2e34e712d804efe8a198e11',
                                      'withSource' => 'true',
                                      'withInput' => 'true',
                                      'withOutput' => 'true',
                                      'withStderr' => 'true',
                                      'withCmpinfo' => 'true' })

    out = JSON.parse Net::HTTP.get_response(url).body
    sleep 5 if out['status'] != 0
    out = JSON.parse Net::HTTP.get_response(url).body

    p 'output is '
    p out
    returned_status = out['status']
    returned_result = out['result']
    p 'returned is :->'
    p "returned_status: #{out['status']}"
    p "returned_result: #{out['result']}"
    @ret_view = out['output']

    puts out['output']

    case out['result']
    when 15
      @compilation_result = @ret_view
    when 11
      render plain: 'Compilation Error'
    when 12
      render plain: 'Runtime Error'
    when 13
      render plain: 'Time Limit Exceeded'
    when 17
      render plain: 'Memory Limit Exceeded'
    when 19
      render plain: 'Illegal System Call'
    when 20
      render plain: "Internal Error\t"
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
end
