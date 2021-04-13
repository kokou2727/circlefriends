require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  describe '#create' do
    before do
      @hashtag = FactoryBot.build(:hashtag)
    end

    it 'hashnameが存在していれば保存できること' do
      expect(@hashtag).to be_valid
    end

    it 'hashnameが空では保存できないこと' do
      @hashtag.hashname = ''
      @hashtag.valid?
      expect(@hashtag.errors.full_messages).to include("Hashname can't be blank")
    end
  end
end
