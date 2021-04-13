require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    before do
      @like = FactoryBot.build(:like)
    end

    it 'userとpostが紐付いていれば保存できること' do
      expect(@like).to be_valid
    end

    it 'postが紐付いていないと保存できないこと' do
      @like.post = nil
      @like.valid?
      expect(@like.errors.full_messages).to include('Post must exist')
    end

    it 'userが紐付いていないと保存できないこと' do
      @like.user = nil
      @like.valid?
      expect(@like.errors.full_messages).to include('User must exist')
    end
  end
end
