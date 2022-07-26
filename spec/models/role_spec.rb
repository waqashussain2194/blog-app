require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:admin_role) { create(:role, :admin_role) }
  let(:moderator_role) { create(:role, :moderator_role) }

  context 'Role' do
    it 'Admin Role Should be created' do
      expect(admin_role).to be_valid
      expect(admin_role.name).to eq('admin')
    end
    it 'Moderator Role Should be created' do
      expect(moderator_role).to be_valid
      expect(moderator_role.name).to eq('moderator')
    end
  end

  context 'Validates' do
    it 'Roles name presence' do
      admin_role.name = nil
      moderator_role.name = nil
      expect(admin_role).to_not be_valid
      expect(moderator_role).to_not be_valid
    end
  end
end
