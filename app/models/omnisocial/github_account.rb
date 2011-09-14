module Omnisocial
  class GithubAccount < LoginAccount
    def assign_account_info(auth_hash)
      self.remote_account_id  = auth_hash['uid']
      self.login              = auth_hash['user_info']['nickname']
      self.name               = auth_hash['user_info']['name']
      self.access_token       = auth_hash['credentials']['token']
    end

    def account_url
      "http://github.com/#{self.login}"
    end

    def picture_url
      hash = Digest::MD5.hexdigest(self.email)
      "http://www.gravatar.com/avatar/#{hash}"
    end
  end
end
