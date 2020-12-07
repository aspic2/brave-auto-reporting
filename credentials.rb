# Fill in these values with your info and save a local copy
class BraveCredentials

  def initialize()
    @access_token = "Your_access_token"

    # To generate an access token:
    @username = "your_username"
    @password = "your_password"
  end

  attr_reader :access_token
end
