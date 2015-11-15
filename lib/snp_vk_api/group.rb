require 'vkontakte_api'

module SnpVkApi
  class Group
    attr_reader :vk_client
    attr_accessor :id, :user_id, :token, :post_ids

    def initialize(id, user_id = nil, post_ids = nil, token = nil)
      @vk_client = token.nil? ? VkontakteApi::Client.new : VkontakteApi::Client.new(token)
      @id = id.to_i
      @user_id = user_id.to_i
      @post_ids = post_ids
    end

    # Count user comments in group posts
    def posts_user_comment_count
      count = 0
      posts.map do |p|
        vk_client.wall.get_comments(owner_id: id, post_id: p.id).each_with_index do |comment, index|
          next if index == 0
          count += 1 if comment.from_id == user_id
        end
      end
      count
    end

    # Count user likes in group posts
    def posts_user_like_count
      count = 0
      posts.map do |p|
        vk_client.likes.get_list(owner_id: id, type: 'post', item_id: p.id).users.each do |u|
          count += 1 if u == user_id
        end
      end
      count
    end

    # Count user reposts in group posts
    def posts_user_repost_count
      count = 0
      posts.map do |p|
        vk_client.wall.get_reposts(owner_id: id, post_id: p.id).profiles.each do |u|
          count += 1 if u.uid == user_id
        end
      end
      count
    end

    private

    def posts
      if post_ids.nil?
        posts = vk_client.wall.get(owner_id: id)
        @post_count = posts[0]
        posts.shift
      else
        posts = vk_client.wall.getById(posts: post_ids_string)
        @post_count = posts.size
      end
      posts
    end

    def post_ids_string
      post_ids.map { |p| "#{id}_#{p}" }.join ','
    end
  end
end
