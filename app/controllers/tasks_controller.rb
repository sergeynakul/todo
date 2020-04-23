class TasksController < ApplicationController
  before_action :set_todo_list, only: %i[new create]
  before_action :set_task, only: %i[show edit update destroy]
  before_action :check_author, only: %i[show edit update destroy]

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
      redirect_to @task, notice: 'Task successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to todo_list_path(@task.todo_list), notice: 'Task successfully deleted.'
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_task
    @task = Task.find(params[:id])
    redirect_to todo_lists_path, alert: 'You do not have access to this resource.' unless current_user.author?(@task.todo_list)
  end

  def check_author
    redirect_to root_path, alert: 'You are not author' unless current_user.author?(@task.todo_list)
  end

  def task_params
    params.require(:task).permit(:description, :expiration_time)
  end
end
