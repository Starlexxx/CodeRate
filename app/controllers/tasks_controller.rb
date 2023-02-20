# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: :show

  def index
    @tasks = Task.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def test_code
    @response = RemoteCodeCompiler.call(compiler_params)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def compiler_params
    {
      language: params[:language],
      source_code: params[:source_code].first,
      memory_limit: params[:memory_limit],
      time_limit: params[:time_limit],
      inputs: params[:inputs],
      tests: params[:tests]
    }
  end
end
