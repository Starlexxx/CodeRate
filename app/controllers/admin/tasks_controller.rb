class Admin::TasksController < Admin::AdminController
  before_action :set_task, only: [ :edit, :update, :destroy ]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, success: 'Задание успешно создано'
    else
      flash.now[:danger] = 'Задание не создано'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, success: 'Задание успешно обновлено'
    else
      flash.now[:danger] = 'Задание не обновлено'
      render :edit
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
    params.require(:task).permit(:title, :body, :category_id)
    params.require(:task).permit(:title, :picture, :body, :category_id)
  end
end