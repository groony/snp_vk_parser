module SnpVkApi
  class Group
    attr_reader :vk_client
    attr_accessor :id, :user_id, :token, :post_ids
  end
end
