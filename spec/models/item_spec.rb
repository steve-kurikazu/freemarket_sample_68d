require 'rails_helper'

describe Item do
  describe '#create' do

    before do
      @user = FactoryBot.create(:user)
      @category = FactoryBot.create(:category)
    end

    it "is valid with a name, text, condition, delivery_fee, shipping_area, delivery_time, price, status" do
      expect(build(:item)).to be_valid
    end

    it "is invalid without a name" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "is invalid without a text" do
      item = build(:item, text: nil)
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    it "is invalid without a condition" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "is invalid without a delivery_fee" do
      item = build(:item, delivery_fee: nil)
      item.valid?
      expect(item.errors[:delivery_fee]).to include("を入力してください")
    end

    it "is invalid without a shipping_area" do
      item = build(:item, shipping_area: nil)
      item.valid?
      expect(item.errors[:shipping_area]).to include("を入力してください")
    end
    
    it "is invalid without a delivery_time" do
      item = build(:item, delivery_time: nil)
      item.valid?
      expect(item.errors[:delivery_time]).to include("は数値で入力してください")
    end

    it "is invalid without a price" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end

    it "is invalid without a status" do
      item = build(:item, status: nil)
      item.valid?
      expect(item.errors[:status]).to include("を入力してください")
    end
    
    it "is valid with a name that has less than 10 characters " do
      item = build(:item, name: "aaaaaaaaaa")
      expect(item).to be_valid
    end

    it "is invalid with a name that has more than 11 characters " do
      item = build(:item, name: "aaaaaaaaaaa")
      item.valid?
      expect(item.errors[:name]).to include("は10文字以内で入力してください")
    end

    it "is valid with a text that has less than 1000 characters " do
      item = build(:item, text: "a" * 1000)
      expect(item).to be_valid
    end

    it "is invalid with a text that has more than 1001 characters " do
      item = build(:item, text: "a" * 1001)
      item.valid?
      expect(item.errors[:text]).to include("は1000文字以内で入力してください")
    end

    it "is valid with a delivery_time by hankaku number " do
      item = build(:item, delivery_time: "1")
      expect(item).to be_valid
    end

    it "is invalid with a delivery_time by zankaku number " do
      item = build(:item, delivery_time: "１")
      item.valid?
      expect(item.errors[:delivery_time]).to include("が不正な値になっています")
    end

    it "is valid with a price by hankaku number " do
      item = build(:item, price: "1")
      expect(item).to be_valid
    end

    it "is invalid with a price by zankaku number " do
      item = build(:item, price: "１")
      item.valid?
      expect(item.errors[:price]).to include("が不正な値になっています")
    end

  end
end