require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:comment) { create(:comment, user_id: user.id, commentable_id: post.id) }
  let!(:reaction) { create(:reaction, user_id: user.id, likeable_id: comment.id, likeable_type: 'Comment') }
  let!(:report) { create(:report, user_id: user.id, reportable_id: comment.id, reportable_type: 'Comment') }
  let!(:reply) { create(:comment, user_id: user.id, commentable_id: comment.id, commentable_type: 'Comment') }

  context 'Comment' do
    it 'Should be created' do
      expect(comment).to be_valid
    end
  end

  context 'Validates' do
    it 'content presence' do
      comment.content = nil
      expect(comment).to_not be_valid
      expect(comment.errors.messages[:content].first).to eq("can't be blank")
    end

    it 'user presence' do
      comment.user_id = nil
      expect(comment).to_not be_valid
      expect(comment.errors.messages[:user].first).to eq('must exist')
    end

    it 'Commentable Type presence' do
      comment.commentable_type = nil
      expect(comment).to_not be_valid
      expect(comment.errors.messages[:commentable_type].first).to eq("can't be blank")
    end

    it 'Commentable id presence' do
      comment.commentable_id = nil
      expect(comment).to_not be_valid
      expect(comment.errors.messages[:commentable_id].first).to eq("can't be blank")
    end
  end

  context 'Associations' do
    it 'Belongs to User' do
      expect(comment.user).to eq(user)
    end
    it 'Belongs to commentable' do
      expect(comment.commentable_type).to eq('Post')
    end
    it 'Has many reactions' do
      expect(comment.reactions.count).to eq(1)
    end
    it 'Has many reports' do
      expect(comment.reports.count).to eq(1)
    end
    it 'Has many replies' do
      expect(comment.comments.count).to eq(1)
    end
  end
end
