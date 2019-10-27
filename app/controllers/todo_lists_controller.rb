class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[show edit update destroy]

  def index
    @todo_lists = current_user.todo_lists
  end

  def show
    @tasks = @todo_list.tasks
  end

  def new
    @todo_list = TodoList.new
  end

  def edit; end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)
    if @todo_list.save
      redirect_to @todo_list, notice: 'Todo List successfully created.'
    else
      render :new
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list
    else
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_path
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
