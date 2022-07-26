require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:report) { create(:report, user_id: user.id, reportable_id: post.id) }

  context 'Report' do
    it 'Should be created' do
      expect(report).to be_valid
    end
  end

  context 'Validates' do
    it 'user id presence' do
      report.user_id = nil
      expect(report).to_not be_valid
      expect(report.errors.messages[:user].first).to eq('must exist')
    end

    it 'reportable id presenece' do
      report.reportable_id = nil
      expect(report).to_not be_valid
      expect(report.errors.messages[:reportable_id].first).to eq("can't be blank")
    end

    it 'reportable type presence' do
      report.reportable_type = nil
      expect(report).to_not be_valid
      expect(report.errors.messages[:reportable_type].first).to eq("can't be blank")
    end
  end

  it { should belong_to(:user) }
  it { should belong_to(:reportable) }
end
