require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let!(:post1) { create(:post, user_id: user.id, approved: true) }
  let!(:post2) { create(:post, user_id: user.id, approved: true) }
  let!(:post3) { create(:post, user_id: user.id, approved: false) }
  let!(:post4) { create(:post, user_id: user.id, approved: false) }

  context 'Post' do
    it 'Should be created' do
      expect(post).to be_valid
    end
  end

  context 'Validates' do
    it 'title presence' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'user presence' do
      post.user_id = nil
      expect(post).to_not be_valid
    end
  end

  context 'Scope' do
    it 'Should return approved Posts' do
      expect(Post.with_approval.size).to eq(2)
    end

    it 'Should return unapproved Posts' do
      expect(Post.without_approval.size).to eq(2)
    end
  end

  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should have_many(:reactions) }
  it { should have_many(:suggestions) }
  it { should have_many(:reports) }
end
