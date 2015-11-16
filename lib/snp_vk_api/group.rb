require 'vkontakte_api'

module SnpVkApi
  # Class for work with group and user in group.
  class Group
    attr_reader :vk_client
    attr_accessor :id, :user_id, :token, :post_ids, :album_ids

    # Set id and initialize vk client.
    # @param [Integer] id Group id.
    def id=(id)
      @id = id
      @vk_client =
        if token.nil?
          VkontakteApi::Client.new
        else
          VkontakteApi::Client.new token
        end
    end

    # Count user comments in posts.
    # @return [Integer] Ammount of comments.
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

    # Count user likes in posts.
    # @return [Integer] Ammount of likes.
    def posts_user_like_count
      count = 0
      posts.map do |p|
        vk_client.likes.get_list(owner_id: id, type: 'post', item_id: p.id).users.each do |u|
          count += 1 if u == user_id
        end
      end
      count
    end

    # Count user reposts in posts.
    # @return [Integer] Ammount of reposts.
    def posts_user_repost_count
      count = 0
      posts.map do |p|
        vk_client.wall.get_reposts(owner_id: id, post_id: p.id).profiles.each do |u|
          count += 1 if u.uid == user_id
        end
      end
      count
    end

    # Count user photos in albums.
    # @return [Integer] Ammount of photos.
    def albums_user_photo_count
      count = 0
      albums.each do |a|
        vk_client.photos.get(owner_id: a.owner_id, album_id: a.aid).each do |p|
          count += 1 if p.user_id == user_id
        end
      end
      count
    end

    # Check user is member.
    # @return [Boolean]
    def member?
      vk_client.groups.is_member(group_id: id.abs, user_id: user_id) == 1
    end

    # Members ids.
    # @return [Array] Array of user ids.
    def members
      vk_client.groups.get_members(group_id: id.abs).users
    end

    private

    # Get posts.
    # @return [Array] Array of posts.
    def posts
      if post_ids.respond_to?(:each) && post_ids.any?
        posts = vk_client.wall.getById(posts: post_ids_string)
      else
        posts = vk_client.wall.get(owner_id: id)
        posts.shift
      end
      posts
    end

    # Convert post ids to string.
    # @return [String] Post ids with owner.
    def post_ids_string
      post_ids.map { |p| "#{id}_#{p}" }.join ','
    end

    # Get albums.
    # @return [Array] Array of albums.
    def albums
      if album_ids.respond_to?(:each) && album_ids.any?
        vk_client.photos.get_albums(owner_id: id, album_ids: album_ids.join(','))
      else
        vk_client.photos.get_albums(owner_id: id)
      end
    end
  end
end
