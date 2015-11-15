FactoryGirl.define do
  factory :all_posts, class: SnpVkApi::Group do
    skip_create
    id(-554_031_06)
    user_id 197_843_786
    initialize_with { new(id, user_id) }
  end

  factory :specific_posts, class: SnpVkApi::Group do
    skip_create
    id(-554_031_06)
    user_id 322_349_840
    post_ids [284_279]
    initialize_with { new(id, user_id, post_ids) }
  end
end
