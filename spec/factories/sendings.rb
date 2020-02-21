FactoryBot.define do

  factory :sending do
    first_name           {"山田"}
    last_name            {"彩"}
    first_namekana       {"ヤマダ"}
    last_namekana        {"アヤ"}
    postal_code          {"１２３−４５６"}
    prefectures          {"北海道"}
    city                 {"横浜市緑区"}      
    address              {"青山１−１−１"}
  end

end