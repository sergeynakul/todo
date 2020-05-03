require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create :user }
  let(:todo_list) { create(:todo_list, user: user) }
  let!(:task) { create(:task, todo_list: todo_list) }

  before { log_in(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'assigns the requested todo list in @todo_list' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task), format: :js }
        expect(assigns(:todo_list)).to eq todo_list
      end

      it 'saves a new todo list in the database' do
        expect { post :create, params: { todo_list_id: todo_list, task: attributes_for(:task), format: :js } }.to change(todo_list.tasks, :count).by(1)
      end

      it 'renders template create' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task), format: :js }
        expect(response).to render_template :create
      end

      it 'created task belongs to todo list' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task), format: :js }
        expect(assigns(:task).todo_list).to eq todo_list
      end
    end

    context 'with invalid attributes' do
      it 'does not save a new task in the database' do
        expect { post :create, params: { todo_list_id: todo_list, task: attributes_for(:task, :invalid), format: :js } }.to_not change(Task, :count)
      end

      it 'renders template create' do
        post :create, params: { todo_list_id: todo_list, task: attributes_for(:task, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested task to @task' do
        patch :update, params: { id: task, task: attributes_for(:task), format: :js }
        expect(assigns(:task)).to eq task
      end

      it 'changes task' do
        patch :update, params: { id: task, task: { description: 'new description' }, format: :js }
        task.reload
        expect(task.description).to eq 'new description'
      end

      it 'redirects to updated task' do
        patch :update, params: { id: task, task: { description: 'new description' }, format: :js }
        expect(response).to redirect_to assigns(:task)
      end
    end

    context 'with invalid attributes' do
      it 'does not changes task' do
        expect { patch :update, params: { id: task, task: attributes_for(:task, :invalid), format: :js } }.to_not change(task, :description)
      end

      it 'renders template update' do
        patch :update, params: { id: task, task: attributes_for(:task, :invalid), format: :js }
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'assigns the requested task in @task' do
      delete :destroy, params: { id: task, format: :js }
      expect(assigns(:task)).to eq task
    end

    it 'deletes the task' do
      expect { delete :destroy, params: { id: task, format: :js } }.to change(Task, :count).by(-1)
    end

    it 'renders template destroy' do
      delete :destroy, params: { id: task, format: :js }
      expect(response).to render_template :destroy
    end
  end
end
