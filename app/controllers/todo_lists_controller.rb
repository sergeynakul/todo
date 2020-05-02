class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[show update destroy]
  before_action :check_author, only: %i[show update destroy]

  def index
    @todo_lists = current_user.todo_lists
    @todo_list = TodoList.new
  end

  def show
    @tasks = @todo_list.tasks
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)
    flash.now[:notice] = 'Todo List successfully created.' if @todo_list.save
  end

  def update
    flash.now[:notice] = 'Todo List successfully updated.' if @todo_list.update(todo_list_params)
  end

  def destroy
    @todo_list.destroy
    flash.now[:notice] = 'Todo List successfully deleted.'
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  def check_author
    redirect_to root_path, alert: 'You are not author' unless current_user.author?(@todo_list)
  end

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
