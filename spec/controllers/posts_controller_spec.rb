require 'spec_helper'

describe PostsController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:moderator_user) { create(:user, :moderator) }
  let!(:post1) { create(:post, user_id: user.id) }

  # Index Action
  context 'GET #index' do
    it 'Renders Index for Every Non-user' do
      get :index, params: { page: 3 }
      expect(response).to render_template(:index)
      expect(assigns[:posts].count).to eq(Post.with_approval.page.count)
    end
    it 'Renders Index for Admin User' do
      sign_in admin_user
      get :index, params: { page: 3 }
      expect(response).to render_template(:index)
      expect(assigns[:posts].count).to eq(Post.with_approval.page.count)
    end
    it 'Renders Index for moderator' do
      sign_in moderator_user
      get :index, params: { page: 3 }
      expect(response).to render_template(:index)
      expect(assigns[:posts].count).to eq(Post.with_approval.page.count)
    end
  end

  # Show Action
  context 'GET #show' do
    it 'Shows Post for Every Non-user' do
      get :show, params: { id: post1.id }
      expect(response).to render_template(:show)
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_valid
    end
    it 'Renders Post for Admin' do
      sign_in admin_user
      get :show, params: { id: post1.id }
      expect(response).to render_template(:show)
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_valid
    end
    it 'Renders Post for moderator' do
      sign_in moderator_user
      get :show, params: { id: post1.id }
      expect(response).to render_template(:show)
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_valid
    end
  end

  # New Action
  context 'GET #new' do
    it 'Successfully renders New for Signed in Users' do
      sign_in user
      get :new
      expect(response).to render_template(:new)
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_new_record
    end
    it 'Renders New for Admin' do
      sign_in admin_user
      get :new
      expect(response).to render_template(:new)
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_new_record
    end
    it 'Renders New for moderator' do
      sign_in moderator_user
      get :new
      expect(response).to render_template(:new)
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_new_record
    end
    it 'Redirects sign in if user not logged in' do
      get :new
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  # Create Action
  context 'POST #create' do
    let(:post_params) { { title: post1.title, content: post1.content, approved: post1.approved } }

    it 'Creates Post for Signed in User' do
      sign_in user
      expect do
        post :create, params: { post: post_params }
      end.to change(Post, :count).by(1)
      expect(flash[:notice]).to eq('Your Post is submitted for approval!')
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_valid
      expect(response).to redirect_to(root_path)
    end
    it 'Creates Post for Admin' do
      sign_in admin_user
      expect do
        post :create, params: { post: post_params }
      end.to change(Post, :count).by(1)
      expect(flash[:notice]).to eq('Your Post Has Been Created Successfully!')
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_valid
    end
    it 'Creates Post for moderator' do
      sign_in moderator_user
      expect do
        post :create, params: { post: post_params }
      end.to change(Post, :count).by(1)
      expect(flash[:notice]).to eq('Your Post Has Been Created Successfully!')
      expect(assigns[:post].class.name).to eq('Post')
      expect(assigns[:post]).to be_valid
    end
    it 'Redirects sign in if user not logged in' do
      post :create
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
    it 'Throws No creation error (title missing)' do
      sign_in user
      post :create, params: { post: { title: nil, content: post1.content, approved: post1.approved } }
      expect(response).to redirect_to(new_post_path)
      expect(flash[:alert]).to eq('Post Title Cannot Be Empty')
      expect(assigns[:post]).to_not be_valid
      expect(response).to redirect_to(new_post_path)
    end
  end

  # Edit Action
  context 'GET #edit' do
    it 'Renders Edit for Owner User' do
      sign_in user
      get :edit, params: { id: post1.id }
      expect(assigns[:post]).to eq(post1)
      expect(response).to render_template(:edit)
    end
    it 'Renders Edit for Admin' do
      sign_in admin_user
      get :edit, params: { id: post1.id }
      expect(assigns[:post]).to eq(post1)
      expect(response).to render_template(:edit)
    end
    it 'Ensures Edit for moderator' do
      sign_in moderator_user
      expect do
        get :edit, params: { id: post1.id }
      end.to raise_error(Pundit::NotAuthorizedError)
    end
    it 'Redirects to Sign in for edit' do
      get :edit, params: { id: post1.id }
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
    it 'Ensures Pundit Auth for edit' do
      sign_in another_user
      expect do
        get :edit, params: { id: post1.id }
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  # Update Action
  context 'PATCH #update' do
    let(:post_params) { { title: Faker::Lorem.characters(min_alpha: 5), content: Faker::Lorem.characters(min_alpha: 5) } }
    let(:post_params_errorneous) { { title: nil, content: Faker::Lorem.characters(min_alpha: 5) } }
    it 'Updates Post for owner user' do
      sign_in user
      put :update, params: { id: post1.id, post: post_params }
      expect(assigns[:post]).to be_valid
      expect(response).to redirect_to(post_path)
      expect(flash[:notice]).to eq('Post Updated Successfully!')
    end
    it 'Updates Post for Admin' do
      sign_in admin_user
      put :update, params: { id: post1.id, post: post_params }
      expect(assigns[:post]).to be_valid
      expect(response).to redirect_to(post_path)
      expect(flash[:notice]).to eq('Post Updated Successfully!')
    end
    it 'Ensures Update for moderator' do
      sign_in moderator_user
      expect do
        put :update, params: { id: post1.id, post: post_params }
      end.to raise_error(Pundit::NotAuthorizedError)
    end
    it 'Redirects sign in if user not logged in' do
      put :update, params: { id: post1.id, post1: post_params }
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
    it 'Ensures Pundit Auth for update' do
      sign_in another_user
      expect do
        put :update, params: { id: post1.id, post1: post_params }
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  # Destroy Action
  context 'DELETE #destroy' do
    it 'Deletes Post for Owner User' do
      sign_in user
      expect { delete :destroy, params: { id: post1.id } }.to change(Post, :count).by(-1)
      expect(flash[:notice]).to eq('Post Deleted Successfully!')
    end
    it 'Deletes Post for Admin' do
      sign_in admin_user
      expect { delete :destroy, params: { id: post1.id } }.to change(Post, :count).by(-1)
      expect(flash[:notice]).to eq('Post Deleted Successfully!')
    end
    it 'Deletes Post for moderator' do
      sign_in moderator_user
      expect { delete :destroy, params: { id: post1.id } }.to change(Post, :count).by(-1)
      expect(flash[:notice]).to eq('Post Deleted Successfully!')
    end
    it 'Redirects sign in if user not logged in' do
      delete :destroy, params: { id: post1.id }
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
    it 'Ensures Pundit Auth for delete' do
      sign_in another_user
      expect do
        delete :destroy, params: { id: post1.id }
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  # Profile Action
  context 'GET #profile' do
    it 'Shows profile for Moderator' do
      sign_in moderator_user
      get :profile
      expect(response).to render_template(:profile)
      expect(assigns[:posts].count).to eq(Post.without_approval.count)
    end
    it 'Ensure Profile for Admin' do
      sign_in admin_user
      expect { get :profile }.to raise_error(Pundit::NotAuthorizedError)
    end
    it 'Ensures Profile for Simple user' do
      sign_in user
      expect { get :profile }.to raise_error(Pundit::NotAuthorizedError)
    end
    it 'Redirects sign in if user not logged in' do
      get :profile
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
    it 'Ensures Pundit Auth for profile' do
      sign_in another_user
      expect { get :profile }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  # Accept Post Action
  context 'GET #accept_post' do
    it 'Accepts post1 for Moderator' do
      sign_in moderator_user
      prev_count = Post.with_approval.count
      get :accept_post, params: { id: post1.id }
      expect(Post.with_approval.size).to eq(prev_count + 1)
    end
    it 'Ensure Accept post for Admin' do
      sign_in admin_user
      expect { get :accept_post, params: { id: post1.id } }.to raise_error(Pundit::NotAuthorizedError)
    end
    it 'Ensures Accept post for Simple user' do
      sign_in user
      expect { get :accept_post, params: { id: post1.id } }.to raise_error(Pundit::NotAuthorizedError)
    end
    it 'Redirects sign in if user not logged in' do
      get :accept_post, params: { id: post1.id }
      expect(response).to redirect_to('http://test.host/users/sign_in')
    end
    it 'Ensures Pundit Auth for accept post' do
      sign_in another_user
      expect { get :accept_post, params: { id: post1.id } }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
