require 'rails_helper'

describe Sending do
  describe '#create' do
    it "is invalid without a :first_name, :last_name, first_namekana, last_namekana, postal_code, prefectures, city, address" do
      sending = build(:sending)
      expect(sending).to be_valid
    end

    it "is invalid without a first_name" do
      sending = build(:sending, first_name: nil)
      sending.valid?
      expect(sending.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last_name" do
      sending = build(:sending, last_name: nil)
      sending.valid?
      expect(sending.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without a password" do
      sending = build(:sending, first_namekana: nil)
      sending.valid?
      expect(sending.errors[:first_namekana]).to include("can't be blank")
    end

    it "is invalid without a last_namekana" do
      sending = build(:sending, last_namekana: nil)
      sending.valid?
      expect(sending.errors[:last_namekana]).to include("can't be blank")
    end

    it "is invalid with a postal_code" do
      sending = build(:sending, postal_code: nil)
      sending.valid?
      expect(sending.errors[:postal_code]).to include("can't be blank")
    end

    it "is valid with a prefectures" do
      sending = build(:sending, prefectures: nil)
      sending.valid?
      expect(sending.errors[:prefectures]).to include("can't be blank")
    end

    
    it "is invalid with a city" do
      sending = build(:sending, city: nil)
      sending.valid?
      expect(sending.errors[:city]).to include("can't be blank")
    end

    it "is valid with a address " do
      sending = build(:sending, address: nil)
      sending.valid?
      expect(sending.errors[:address]).to include("can't be blank")
    end
  end
end
