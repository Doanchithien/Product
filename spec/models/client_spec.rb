require 'rails_helper'

RSpec.describe Client, type: :model do
  it 'is valid with valid attributes' do
    client = FactoryBot.build(:client)
    expect(client).to be_valid
  end

  it 'is not valid without an email' do
    client = FactoryBot.build(:client, email: nil)
    expect(client).to_not be_valid
  end

  it 'is not valid without a password' do
    client = FactoryBot.build(:client, password: nil)
    expect(client).to_not be_valid
  end

  it 'is not valid without a name' do
    client = FactoryBot.build(:client, name: nil)
    expect(client).to_not be_valid
  end

  it 'is not valid with a duplicate email' do
    FactoryBot.create(:client, email: 'test@example.com')
    client = FactoryBot.build(:client, email: 'test@example.com')
    expect(client).to_not be_valid
  end

  it 'is not valid with wrong format email' do
    client = FactoryBot.build(:client, email: 'test@.com')
    expect(client).to_not be_valid
  end
end