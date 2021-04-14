require 'rails_helper'

RSpec.describe Group, type: :model do
  describe '#create' do
    before do
      @group = FactoryBot.build(:group)
    end

    it 'group_nameの値が存在すれば登録できること' do
      expect(@group).to be_valid
    end

    it 'group_nameが空では登録できないこと' do
      @group.group_name = ''
      @group.valid?
      expect(@group.errors.full_messages).to include("Group name can't be blank")
    end
  end
end
