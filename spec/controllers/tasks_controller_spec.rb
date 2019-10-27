require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create :user }
  let(:todo_list) { create :todo_list }
  let(:task) { create :task }

  before { log_in(user) }

  describe 'GET #show' do
    before { get :show, params: { id: task } }

    it 'assigns the requested task in @task' do
      expect(assigns(:task)).to eq task
    end

    it 'renders show' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { todo_list_id: todo_list } }

    it 'assigns the requested todo list in @todo_list' do
      expect(assigns(:todo_list)).to eq todo_list
    end

    it 'assigns a new task in @task' do
      expect(assigns(:task)).to be_a_new(Task)
    end

    it 'renders new' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: task } }

    it 'assigns the requested task in @task' do
      expect(assigns(:task)).to eq task
    end

    it 'renders edit' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'assigns the requested todo list in @todo_list' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task) }
        expect(assigns(:todo_list)).to eq todo_list
      end

      it 'saves a new todo list in the database' do
        expect { post :create, params: { todo_list_id: todo_list, task: attributes_for(:task) } }.to change(todo_list.tasks, :count).by(1)
      end

      it 'redirects to todo list' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task) }
        expect(response).to redirect_to assigns(:todo_list)
      end

      it 'created task belongs to todo list' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task) }
        expect(assigns(:task).todo_list).to eq todo_list
      end
    end

    context 'with invalid attributes' do
      it 'does not save a new task in the database' do
        expect { post :create, params: { todo_list_id: todo_list, task: attributes_for(:task, :invalid) } }.to_not change(Task, :count)
      end

      it 're-renders new' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested task to @task' do
        patch :update, params: { id: task, task: attributes_for(:task) }
        expect(assigns(:task)).to eq task
      end

      it 'changes task' do
        patch :update, params: { id: task, task: { description: 'new description' } }
        task.reload
        expect(task.description).to eq 'new description'
      end

      it 'redirects to updated task' do
        patch :update, params: { id: task, task: { description: 'new description' } }
        expect(response).to redirect_to assigns(:task)
      end
    end

    context 'with invalid attributes' do
      it 'does not changes task' do
        expect { patch :update, params: { id: task, task: attributes_for(:task, :invalid) } }.to_not change(task, :description)
      end

      it 're-renders edit' do
        patch :update, params: { id: task, task: attributes_for(:task, :invalid) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { create :task }

    it 'assigns the requested task in @task' do
      delete :destroy, params: { id: task }
      expect(assigns(:task)).to eq task
    end

    it 'deletes the task' do
      expect { delete :destroy, params: { id: task } }.to change(Task, :count).by(-1)
    end

    it 'redirects to todo list' do
      delete :destroy, params: { id: task }
      expect(response).to redirect_to todo_list_path(task.todo_list)
    end
  end
end
