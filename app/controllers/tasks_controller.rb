class TasksController < ApplicationController

  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, success: 'Задание успешно создано'
    else
      render :new, danger: 'Задание не создано'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, success: 'Задание успешно обновлено'
    else
      render :edit, danger: 'Задание не обновлено'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, success: 'Задание успешно удалено'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :body)
  end
end