require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user = FactoryBot.build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with a duplicate email' do
    FactoryBot.create(:user, email: 'test@example.com')
    user = FactoryBot.build(:user, email: 'test@example.com')
    expect(user).to_not be_valid
  end

  it 'is not valid with wrong format email' do
    user = FactoryBot.build(:user, email: 'test@.com')
    expect(user).to_not be_valid
  end
end
