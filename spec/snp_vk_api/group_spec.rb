require 'spec_helper'

describe SnpVkApi::Group, vcr: true do
  let(:subject) { build(:all_posts) }

  it { should respond_to :vk_client }
  it { should respond_to :id }
  it { should respond_to :user_id }
  it { should respond_to :token }
  it { should respond_to :post_ids }

  context 'with all posts in group' do
    it_behaves_like 'posts' do
      let(:user_with_data) { build(:all_posts) }
      let(:user_without_data) { build(:all_posts, user_id: 1) }
    end
  end

  context 'with specific posts in group' do
    it_behaves_like 'posts' do
      let(:user_with_data) { build(:specific_posts) }
      let(:user_without_data) { build(:specific_posts, user_id: 1) }
    end
  end
end
