class TasksController < ApplicationController
  before_action :set_todo_list, only: :create
  before_action :set_task, only: %i[update destroy]
  before_action :check_author, only: %i[update destroy]

  def create
    @task = @todo_list.tasks.new(task_params)
    flash.now[:notice] = 'Task successfully created.' if @task.save
  end

  def update
    flash.now[:notice] = 'Task successfully updated.' if @task.update(task_params)
  end

  def destroy
    flash.now[:notice] = 'Task successfully deleted.' if @task.destroy
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_author
    redirect_to root_path, alert: 'You are not author' unless current_user.author?(@task.todo_list)
  end

  def task_params
    params.require(:task).permit(:description, :expiration_time, :done)
  end
end
