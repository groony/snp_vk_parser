shared_examples_for 'posts' do
  context 'posts_user_comment_count' do
    it('positive') { user_with_data.posts_user_comment_count.should be > 0 }
    it('zero') { user_without_data.posts_user_comment_count.should be 0 }
  end

  context 'posts_user_like_count' do
    it('positive') { user_with_data.posts_user_like_count.should be > 0 }
    it('zero') { user_without_data.posts_user_like_count.should be 0 }
  end

  context 'posts_user_repost_count' do
    it('positive') { user_with_data.posts_user_repost_count.should be > 0 }
    it('zero') { user_without_data.posts_user_repost_count.should be 0 }
  end
end
