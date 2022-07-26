require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'User' do
    it 'Should be created' do
      expect(user).to be_valid
    end
  end

  context 'Validates' do
    it 'first name presence' do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it 'last name presence' do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it 'email presence' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'password presence' do
      user.password = nil
      expect(user).to_not be_valid
    end
  end

  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:reactions) }
  it { should have_many(:reports) }
  it { should have_many(:suggestions) }
end
