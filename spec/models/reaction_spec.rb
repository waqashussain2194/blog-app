require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:reaction) { create(:reaction, user_id: user.id, likeable_id: post.id) }

  context 'Reaction' do
    it 'Should be created' do
      expect(reaction).to be_valid
    end
  end

  context 'Validates' do
    it 'user id presence' do
      reaction.user_id = nil
      expect(reaction).to_not be_valid
    end

    it 'likeable id presenece' do
      reaction.likeable_id = nil
      expect(reaction).to_not be_valid
    end

    it 'likeable type presence' do
      reaction.likeable_type = nil
      expect(reaction).to_not be_valid
    end
  end

  context 'Associations' do
    it 'Belongs to User' do
      expect(reaction.user).to eq(user)
    end
    it 'Belongs to Likeable' do
      expect(reaction.likeable_type).to eq('Post')
    end
  end
end
