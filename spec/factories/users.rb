def i_n(password, str)
  str.length.times do |time|
    l = password.length
    r = rand(l + 1)
    password.insert(r, str[time])
  end
  password
end

def ra_na(chars, num)
  Array.new(num) { chars.sample }.join
end

FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password do
      password = Faker::Internet.password

      unless password.match?(/\d/)
        str = Faker::Number.number(digits: rand(1..9))
        password = i_n(password, str)
      end
      unless password.match?(/[A-Za-z]/)
        str = Faker::Alphanumeric.alpha(number: rand(1..9))
        password = i_n(password, str)
      end
      password
    end
    password_confirmation { password }
    last_name do
      chars = (['ぁ'..'ん', 'ァ'..'ヶ', '一'..'龥'].map(&:to_a).flatten + %W[\u3005 \u30FC ヴ])
      num = rand(1..5)
      ra_na(chars, num)
    end
    first_name do
      chars = (['ぁ'..'ん', 'ァ'..'ヶ', '一'..'龥'].map(&:to_a).flatten + %W[\u3005 \u30FC ヴ])
      num = rand(1..5)
      ra_na(chars, num)
    end
    last_name_kana do
      chars = ('ァ'..'ヶ').to_a + %W[\u30FC \u30F4]
      num = rand(3..8)
      ra_na(chars, num)
    end
    first_name_kana do
      chars = ('ァ'..'ヶ').to_a + %W[\u30FC \u30F4]
      num = rand(3..8)
      ra_na(chars, num)
    end
    birth_date { Faker::Date.birthday }
  end
end
