require 'spec_helper'

describe SnpVkApi::Group do
  let(:subject) { build(:all_posts) }

  it { should respond_to :vk_client }
  it { should respond_to :id }
  it { should respond_to :user_id }
  it { should respond_to :token }
  it { should respond_to :post_ids }
end
