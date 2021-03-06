FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :style do
    name "Lager"
    description "Lager is good"
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end

  factory :nanny, class: Beer do
    name "nanny state"
    brewery
    style
  end

  factory :koff, class: Brewery do
    name "Koff"
    year 1891
  end
end
