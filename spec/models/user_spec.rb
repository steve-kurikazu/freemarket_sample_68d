require 'rails_helper'

describe User do
  describe '#create' do
    # nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a nickname, email, firstname, lastname, firstname_kana, lastname_kana, birth_year, birth_month, birth_day password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    # nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    # emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # 名字が空では登録できないこと
    it "is invalid without a lastname" do
      user = build(:user, lastname: nil)
      user.valid?
      expect(user.errors[:lastname]).to include("が不正な値になっています")
    end

    # 名前が空では登録できないこと
    it "is invalid without a firstname" do
      user = build(:user, firstname: nil)
      user.valid?
      expect(user.errors[:firstname]).to include("が不正な値になっています")
    end

    # 名字（かな）が空では登録できないこと
    it "is invalid without a lastname_kana" do
      user = build(:user, lastname_kana: nil)
      user.valid?
      expect(user.errors[:lastname_kana]).to include("が不正な値になっています")
    end

    # 名前（かな）が空では登録できないこと
    it "is invalid without a firstname_kana" do
      user = build(:user, firstname_kana: nil)
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不正な値になっています")
    end

    # 生年月日（年）が空では登録できないこと
    it "is invalid without a birth_year" do
      user = build(:user, birth_year: nil)
      user.valid?
      expect(user.errors[:birth_year]).to include("を入力してください")
    end

    # 生年月日（月）が空では登録できないこと
    it "is invalid without a birth_month" do
      user = build(:user, birth_month: nil)
      user.valid?
      expect(user.errors[:birth_month]).to include("を入力してください")
    end

    # 生年月日（日）が空では登録できないこと
    it "is invalid without a birth_day" do
      user = build(:user, birth_day: nil)
      user.valid?
      expect(user.errors[:birth_day]).to include("を入力してください")
    end

    # passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # nicknameが9文字以上であれば登録できないこと
    it "is invalid with a nickname that has more than 9 characters " do
      user = build(:user, nickname: "aaaaaaaaaaa")
      user.valid?
      expect(user.errors[:nickname]).to include("は8文字以内で入力してください")
    end

    # nicknameが8文字以下では登録できること
    it "is valid with a nickname that has less than 8 characters " do
      user = build(:user, nickname: "aaaaaaaa")
      expect(user).to be_valid
    end

     # passwordが7文字以上であれば登録できること
     it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    # passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    # 名字が半角の場合登録できる
    it "is valid with a zenkaku lastname" do
      user = build(:user, lastname: "新宅ちゃん")
      user.valid?
      expect(user).to be_valid
    end

    # 名字が半角の場合登録できないこと
    it "is invalid with a hankaku lastname" do
      user = build(:user, lastname: "aaaaaaaa")
      user.valid?
      expect(user.errors[:lastname]).to include("が不正な値になっています")
    end

    # 名前が半角の場合登録できる
    it "is valid with a zenkaku firstname" do
      user = build(:user, firstname: "あつしちゃん")
      user.valid?
      expect(user).to be_valid
    end

     # 名前が半角の場合登録できないこと
     it "is invalid with a hankaku firstname" do
      user = build(:user, firstname: "bbbbbbb")
      user.valid?
      expect(user.errors[:firstname]).to include("が不正な値になっています")
    end

    # 名字（かな）がひらがな全角の場合登録できる
    it "is valid with a lastname_kana" do
      user = build(:user, lastname_kana: "しんたくうう")
      user.valid?
      expect(user).to be_valid
    end

     # 名字(かな)が半角の場合登録できないこと
     it "is invalid with a hankaku lastname_kana" do
      user = build(:user, lastname_kana: "aaaaaaaa")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("が不正な値になっています")
    end

     # 名前（かな）がひらがな半角の場合登録できる
    it "is valid with a zenkaku firstname_kana" do
      user = build(:user, firstname_kana: "あつしいいいい")
      user.valid?
      expect(user).to be_valid
    end

     # 名前（かな）が半角の場合登録できないこと
     it "is invalid with a hankaku firstname_kana" do
      user = build(:user, firstname_kana: "aaaaaaaa")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不正な値になっています")
    end

    # 重複したnicknameが存在する場合登録できないこと
    it "is invalid with a duplicate nickname" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("はすでに存在します")
    end

    # 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    

   
  end
end 