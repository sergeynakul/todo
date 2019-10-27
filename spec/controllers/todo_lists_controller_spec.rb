require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  let(:user) { create :user }
  let(:todo_list) { create :todo_list }

  before { log_in(user) }

  describe 'GET #index' do
    let(:todo_lists) { create_list(:todo_list, 3, user: user) }

    before { get :index }

    it 'populates an array of all todo lists' do
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
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new todo list in @todo_list' do
      expect(assigns(:todo_list)).to be_a_new(TodoList)
    end

    it 'renders new' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: todo_list } }

    it 'assigns the requested todo list in @todo_list' do
      expect(assigns(:todo_list)).to eq todo_list
    end

    it 'renders edit' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new todo list in the database' do
        expect { post :create, params: { todo_list: attributes_for(:todo_list) } }.to change(TodoList, :count).by(1)
      end

      it 'redirects to new todo list' do
        post :create, params: { todo_list: attributes_for(:todo_list) }
        expect(response).to redirect_to assigns(:todo_list)
      end

      it 'created todo list belongs to current_user' do
        post :create, params: { todo_list: attributes_for(:todo_list) }
        expect(assigns(:todo_list).user).to eq user
      end
    end

    context 'with invalid attributes' do
      it 'does not save a new todo list in the database' do
        expect { post :create, params: { todo_list: attributes_for(:todo_list, :invalid) } }.to_not change(TodoList, :count)
      end

      it 're-renders new' do
        post :create, params: { todo_list: attributes_for(:todo_list, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested todo list to @todo_list' do
        patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list) }
        expect(assigns(:todo_list)).to eq todo_list
      end

      it 'changes todo list' do
        patch :update, params: { id: todo_list, todo_list: { title: 'new title' } }
        todo_list.reload
        expect(todo_list.title).to eq 'new title'
      end

      it 'redirects to updated todo list' do
        patch :update, params: { id: todo_list, todo_list: { title: 'new title' } }
        expect(response).to redirect_to assigns(:todo_list)
      end
    end

    context 'with invalid attributes' do
      it 'does not changes todo list' do
        expect { patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list, :invalid) } }.to_not change(todo_list, :title)
      end

      it 're-renders edit' do
        patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list, :invalid) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:todo_list) { create :todo_list }

    it 'deletes the todo list' do
      expect { delete :destroy, params: { id: todo_list } }.to change(TodoList, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: todo_list }
      expect(response).to redirect_to todo_lists_path
    end
  end
end
