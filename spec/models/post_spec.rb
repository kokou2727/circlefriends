require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @post = FactoryBot.build(:post)
    end

    it 'textとimageが存在していれば保存できること' do
      expect(@post).to be_valid
    end

    it 'textが空でも保存できること' do
      @post.text = ''
      expect(@post).to be_valid
    end

    it 'imageが空でも保存できること' do
      @post.image = nil
      expect(@post).to be_valid
    end

    it 'textとimageが空では保存できないこと' do
      @post.text = ''
      @post.image = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Text can't be blank")
    end

    it 'userが紐付いていないと保存できないこと' do
      @post.user = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('User must exist')
    end
  end
end
