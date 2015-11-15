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

    # Count user comments in posts
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

    # Count user likes in posts
    def posts_user_like_count
      count = 0
      posts.map do |p|
        vk_client.likes.get_list(owner_id: id, type: 'post', item_id: p.id).users.each do |u|
          count += 1 if u == user_id
        end
      end
      count
    end

    # Count user reposts in posts
    def posts_user_repost_count
      count = 0
      posts.map do |p|
        vk_client.wall.get_reposts(owner_id: id, post_id: p.id).profiles.each do |u|
          count += 1 if u.uid == user_id
        end
      end
      count
    end

    # Count user photos in albums
    def albums_user_photo_count
      count = 0
      albums.each do |a|
        vk_client.photos.get(owner_id: a.owner_id, album_id: a.aid).each do |p|
          count += 1 if p.user_id == user_id
        end
      end
      count
    end

    # Check user is member
    def member?
      vk_client.groups.is_member(group_id: id.abs, user_id: user_id) == 1
    end

    # Members[] ids
    def members
      vk_client.groups.get_members(group_id: id.abs).users
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

    def albums
      vk_client.photos.get_albums(owner_id: id)
    end
  end
end
