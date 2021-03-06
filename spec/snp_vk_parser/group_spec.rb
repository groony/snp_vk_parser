require 'spec_helper'

describe SnpVkParser::Group, vcr: true do
  let(:subject) { build(:all_posts) }
  let(:user_without_data) { build(:all_posts, user_id: 1) }

  it { should respond_to :vk_client }
  it { should respond_to :id }
  it { should respond_to :user_id }
  it { should respond_to :token }
  it { should respond_to :post_ids }
  it { should respond_to :album_ids }
  it { subject.members.should_not be_empty }

  context 'user' do
    it('is member') { subject.member?.should be true }
    it('is not member') { user_without_data.member?.should be false }
  end

  context 'with all albums' do
    context 'albums_user_photo_count' do
      let(:user_with_data) { build(:all_posts, user_id: 264_604_145) }

      it('positive') { user_with_data.albums_user_photo_count.should be > 0 }
      it('zero') { user_without_data.albums_user_photo_count.should be 0 }
    end
  end

  context 'with specific albums' do
    context 'albums_user_photo_count' do
      let(:user_with_data) { build(:specific_albums, user_id: 264_604_145) }

      it('positive') { user_with_data.albums_user_photo_count.should be > 0 }
      it('zero') { user_without_data.albums_user_photo_count.should be 0 }
    end
  end

  context 'with all posts' do
    it_behaves_like 'posts' do
      let(:user_with_data) { build(:all_posts) }
      let(:user_without_data) { build(:all_posts, user_id: 1) }
    end
  end

  context 'with specific posts' do
    it_behaves_like 'posts' do
      let(:user_with_data) { build(:specific_posts) }
      let(:user_without_data) { build(:specific_posts, user_id: 1) }
    end
  end
end
