module Warden
  module Bootic
    module Oauth
      class User
        
        attr_reader :attribs, :token
        
        def initialize(attribs, token)
          @attribs, @token = attribs, token
        end
        
        def user_name
          attribs['user_info']['user_name']
        end

        def email
          attribs['user_info']['email']
        end

        def role
          attribs['user_info']['role_key']
        end
        
      end
    end
  end
end
