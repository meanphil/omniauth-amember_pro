
module OmniAuth
  module Strategies
    class AmemberPro
      include OmniAuth::Strategy

      option :name, "amember_pro"
      option :fields, [ :username, :password ]
      option :auth_url
      option :api_key

      # Set this to true when you configure Rails/Sinatra to use OmniAuth
      # if you want to provide your own login form
      # option :form, true

      def request_phase
        form = OmniAuth::Form.new(:title => "User Info", :url => callback_path)
        form.text_field "Username", 'username'
        form.password_field "Password", 'password'
        form.button "Sign In"
        form.to_response
      end

      def callback_phase
        api = AmemberApiWrapper.new(options)
        
        if api.login!(username, password)
          # If the user logs in with their email address, aMember seems to 
          # think it's a valid login, but then we can't filter the user
          # for their info. So if user_info returns nil in that event, 
          # just pretend it was the wrong username in the first place.
          @raw_info = api.user_info
          if @raw_info.nil?
            fail!(:invalid_credentials)
          else
            super
          end
        else
          fail!(:invalid_credentials)
        end
      end

      uid do
        raw_info['user_id']
      end

      info do
        {
          'name'       => "%s %s" % [ raw_info['name_f'], raw_info['name_l'] ],
          'email'      => raw_info['email'],
          'nickname'   => raw_info['username'],
          'first_name' => raw_info['name_f'],
          'last_name'  => raw_info['name_l'],
          'location'   => raw_info['region']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      %w(username password).each do |field|
        define_method field do
          request[field]
        end
      end
      
    private
      def raw_info
        @raw_info
      end
      
    end
  end
end
