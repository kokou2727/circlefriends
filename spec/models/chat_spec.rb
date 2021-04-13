require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe '#create' do
    before do
      @chat = FactoryBot.build(:chat)
    end

    it 'messageが存在していれば保存できること' do
      expect(@chat).to be_valid
    end

    it 'messageが空では保存できないこと' do
      @chat.message = ''
      @chat.valid?
      expect(@chat.errors.full_messages).to include("Message can't be blank")
    end

    it 'groupが紐付いていないと保存できないこと' do
      @chat.group = nil
      @chat.valid?
      expect(@chat.errors.full_messages).to include('Group must exist')
    end

    it 'userが紐付いていないと保存できないこと' do
      @chat.user = nil
      @chat.valid?
      expect(@chat.errors.full_messages).to include('User must exist')
    end
  end
end
