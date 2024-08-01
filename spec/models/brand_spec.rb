require 'rails_helper'

RSpec.describe Brand, type: :model do
  it 'is valid with valid attributes' do
    brand = FactoryBot.build(:brand)
    expect(brand).to be_valid
  end

  it 'is not valid without a name' do
    brand = FactoryBot.build(:brand, name: nil)
    expect(brand).to_not be_valid
  end

  it 'is not valid without an established_at' do
    brand = FactoryBot.build(:brand, established_at: nil)
    expect(brand).to_not be_valid
  end

  it 'is not valid with a duplicate name' do
    FactoryBot.create(:brand, name: 'Brand A')
    brand = FactoryBot.build(:brand, name: 'Brand A')
    expect(brand).to_not be_valid
  end
end
