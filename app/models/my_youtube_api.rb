class MyYoutubeApi
  def initialize(options)
    @port = options[:port] || 9292
    @authorization = Signet::OAuth2::Client.new({
      :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
      :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
      :redirect_uri => "http://localhost:3000/youtube/auth"}.update(options)#http://li1275-251.members.linode.com
    )
  end


  def authorize(storage=nil)
    auth = @authorization
    return auth.authorization_uri.to_s, @authorization

    #if @authorization.access_token
    #  if storage.respond_to?(:write_credentials)
    #    storage.write_credentials(@authorization)
    #  end
    #  return @authorization
    #else
    #  return nil
    #end
  end
end