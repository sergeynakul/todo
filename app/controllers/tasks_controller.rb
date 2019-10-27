class TasksController < ApplicationController
  before_action :set_todo_list, only: %i[new create]
  before_action :set_task, only: %i[show edit update destroy]

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = @todo_list.tasks.new(task_params)
    if @task.save
      redirect_to @todo_list, notice: 'Task successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to todo_list_path(@task.todo_list)
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :expiration_time)
  end
end