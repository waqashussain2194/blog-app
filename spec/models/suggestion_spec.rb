require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:suggestion) { create(:suggestion, user_id: user.id, post_id: post.id) }

  context 'Suggestion' do
    it 'Should be created' do
      expect(suggestion).to be_valid
    end
  end

  context 'Validates' do
    it 'content presence' do
      suggestion.content = nil
      expect(suggestion).to_not be_valid
    end

    it 'post presence' do
      suggestion.post_id = nil
      expect(suggestion).to_not be_valid
    end

    it 'user presence' do
      suggestion.user_id = nil
      expect(suggestion).to_not be_valid
    end
  end

  it { should have_many(:comments) }
  it { should belong_to(:user) }
  it { should belong_to(:post) }
end
