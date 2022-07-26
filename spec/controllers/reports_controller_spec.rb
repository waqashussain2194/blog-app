require 'spec_helper'

describe ReportsController do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:moderator_user) { create(:user, :moderator) }
  let!(:post1) { create(:post, user_id: user.id) }
  let!(:report) { create(:report, reportable_id: post1.id, user_id: user.id) }

  context 'POST #create' do
    it 'Creates Report for simple user' do
      sign_in user
      expect do
        post :create, params: { post_id: post1.id, report_id: report.id }
      end.to change(Report, :count).by(1)
      expect(flash[:notice]).to eq('You Reported This Post!')
    end
    it 'Creates Report for Admin' do
      sign_in admin_user
      expect do
        post :create, params: { post_id: post1.id, report_id: report.id }
      end.to change(Report, :count).by(1)
      expect(flash[:notice]).to eq('You Reported This Post!')
    end
    it 'Creates Report for Moderator' do
      sign_in moderator_user
      expect do
        post :create, params: { post_id: post1.id, report_id: report.id }
      end.to change(Report, :count).by(1)
      expect(flash[:notice]).to eq('You Reported This Post!')
    end
    it 'Redirects to sign in for Report Create' do
      post :create, params: { post_id: post1.id, report_id: report.id }
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  context 'DELETE #destroy' do
    it 'Destroys Report for Report Owner' do
      sign_in user
      expect { delete :destroy, params: { post_id: post1.id, report_id: report.id } }.to change(Report, :count).by(-1)
      expect(flash[:notice]).to eq('You Undid Report')
    end
    it 'Redirects to sign in for Report Destroy' do
      delete :destroy, params: { post_id: post1.id, report_id: report.id }
      expect(response).to redirect_to('http://test.host/users/sign_in')
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
  end
end
