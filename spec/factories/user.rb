FactoryBot.define do

  factory :user do
    password = Faker::Internet.password(min_length: 7)

    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    lastname {'新宅'}
    firstname  {'淳史'}
    lastname_kana {'しんたく'}
    firstname_kana  {'あつし'}
    birth_year  {Faker::Number}
    birth_month {Faker::Number}
    birth_day {Faker::Number}
    password {password}
    password_confirmation {password}
  end

end
