require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  let(:user) { create :user }
  let(:todo_list) { create(:todo_list, user: user) }

  before { log_in(user) }

  describe 'GET #index' do
    let(:todo_lists) { create_list(:todo_list, 3, user: user) }

    before { get :index }

    it 'populates an array of users todo lists' do
      expect(assigns(:todo_lists)).to match_array(user.todo_lists)
    end

    it 'renders index' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: todo_list } }

    it 'assigns the requested todo list in @todo_list' do
      expect(assigns(:todo_list)).to eq todo_list
    end

    it 'renders show' do
      expect(response).to render_template :show
    end

    it 'populates an array of todo list tasks' do
      expect(assigns(:tasks)).to match_array(todo_list.tasks)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new todo list in the database' do
        expect { post :create, params: { todo_list: attributes_for(:todo_list) }, format: :js }.to change(user.todo_lists, :count).by(1)
      end

      it 'renders template create' do
        post :create, params: { todo_list: attributes_for(:todo_list), format: :js }
        expect(response).to render_template :create
      end

      it 'created todo list belongs to current_user' do
        post :create, params: { todo_list: attributes_for(:todo_list), format: :js }
        expect(assigns(:todo_list).user).to eq user
      end
    end

    context 'with invalid attributes' do
      it 'does not save a new todo list in the database' do
        expect { post :create, params: { todo_list: attributes_for(:todo_list, :invalid) }, format: :js }.to_not change(TodoList, :count)
      end

      it 'renders template create' do
        post :create, params: { todo_list: attributes_for(:todo_list, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested todo list to @todo_list' do
        patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list), format: :js }
        expect(assigns(:todo_list)).to eq todo_list
      end

      it 'changes todo list' do
        patch :update, params: { id: todo_list, todo_list: { title: 'new title' }, format: :js }
        todo_list.reload
        expect(todo_list.title).to eq 'new title'
      end

      it 'redirects to updated todo list' do
        patch :update, params: { id: todo_list, todo_list: { title: 'new title' }, format: :js }
        expect(response).to redirect_to assigns(:todo_list)
      end
    end

    context 'with invalid attributes' do
      it 'does not changes todo list' do
        expect { patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list, :invalid), format: :js } }.to_not change(todo_list, :title)
      end

      it 'renders template update' do
        patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list, :invalid), format: :js }
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:todo_list) { create(:todo_list, user: user) }

    it 'assigns the requested todo list to @todo_list' do
      delete :destroy, params: { id: todo_list, format: :js }
      expect(assigns(:todo_list)).to eq todo_list
    end

    it 'deletes the todo list' do
      expect { delete :destroy, params: { id: todo_list, format: :js } }.to change(TodoList, :count).by(-1)
    end

    it 'renders template destroy' do
      delete :destroy, params: { id: todo_list, format: :js }
      expect(response).to render_template :destroy
    end
  end
end
