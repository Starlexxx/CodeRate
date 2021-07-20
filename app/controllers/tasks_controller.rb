class TasksController < ApplicationController
  before_action :set_task, only: :show

  def index
    @tasks = Task.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
end