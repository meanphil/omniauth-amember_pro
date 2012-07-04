class AmemberApiWrapper
  
  attr_accessor :api_key, :auth_url, :conn
  
  def initialize(options)
    @auth_url = options.auth_url
    
    # Ensure URL has trailing slash, so URI concatenation works later on
    @auth_url += '/' if @auth_url[-1] != '/'
    
    @api_key  = options.api_key
    @conn     = Faraday.new(:url => auth_url)
  end
  
  def login!(username, password)
    result = perform_request('check-access/by-login-pass', {
      login: username,
       pass: password
    })
    if result["ok"] == true
      @username = username
      true
    else
      false
    end
  end
  
  def user_info
    if @username
      perform_request('users', {
        "_filter[login]" => @username
      })["0"]
    else
      raise "User not logged in"
    end
  end
private

  def perform_request(action, params = {})
    uri      = URI.parse(auth_url)
    endpoint = URI.join(uri, 'api/', action.gsub(/^\//, ''))

    response = conn.get do |req|
      req.url endpoint.path
      req.params = { "_key" => api_key }.merge(params)
    end

    if response.status == 200
        MultiJson.load(response.body)
    else
      raise InvalidServerResponse.new("Server responded with code #{response.status}")
    end

  rescue MultiJson::DecodeError => e
    raise InvalidJsonResponse.new("Couldn't parse login response: #{e.message[0..30]}")
  end
  
  
  
  
  class InvalidJsonResponse < StandardError
  end
  
  class InvalidServerResponse < StandardError
  end
  
end