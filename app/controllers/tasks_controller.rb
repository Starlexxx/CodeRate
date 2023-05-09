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
    params.permit(:language, :source_code, :inputs, :tests).merge(source: :tasks_controller)
  end
end
