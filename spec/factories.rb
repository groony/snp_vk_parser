FactoryGirl.define do
  factory :all_posts, class: SnpVkApi::Group do
    skip_create
    id(-554_031_06)
    user_id 197_843_786
  end

  factory :specific_posts, class: SnpVkApi::Group do
    skip_create
    id(-554_031_06)
    user_id 322_349_840
    post_ids [284_279]
  end

  factory :specific_albums, class: SnpVkApi::Group do
    skip_create
    id(-554_031_06)
    user_id 197_843_786
    album_ids [220_194_727, 206_732_504, 200_250_607]
  end
end
