require 'vkontakte_api'

module SnpVkApi
  class Group
    attr_reader :vk_client
    attr_accessor :id, :user_id, :token, :post_ids

    def initialize(id, user_id, post_ids = nil, token = nil)
      @vk_client = token.nil? ? VkontakteApi::Client.new : VkontakteApi::Client.new(token)
      @id = id.to_i
      @user_id = user_id.to_i
      @post_ids = post_ids
    end
  end
end
