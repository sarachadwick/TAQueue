class LtiController < ApplicationController
  skip_before_action :verify_authenticity_token
  after_action :allow_iframe, only: [:launch]
  # TODO: Nonce verification

  def launch
    return head 401 unless authenticated?
    return head 403 unless check_timestamp
    redirect_to '/'
  end

  def authenticated?
    # TODO: Ask William about Keys
    authenticator = IMS::LTI::Services::MessageAuthenticator.new(url, header_options, 'secret')
    authenticator.valid_signature?
  end

  def header_options
    @header_options ||= get_header_options
  end

  def get_header_options
    raw_auth_header = request.headers['Authorization']
    return query_params if raw_auth_header.nil?
    auth_header = {}
    out_values = raw_auth_header.split(" ")[1]
    out_values.split(",").each do |option|
      k, v = option.split("=")
      auth_header[k.to_sym] = CGI.unescape(v.tr('"', ''))
    end
    auth_header
  end

  def query_params
    {
      oauth_consumer_key: params[:oauth_consumer_key],
      oauth_signature_method: params[:oauth_signature_method],
      oauth_timestamp: params[:oauth_timestamp],
      oauth_nonce: params[:oauth_nonce],
      oauth_version: params[:oauth_version],
      oauth_signature: params[:oauth_signature]
    }
  end

  def url
    @url ||= begin
       uri = URI.parse(request.url.to_s)
       uri.scheme = uri.scheme.downcase
       uri.normalize!
       uri.fragment = nil
       uri.query = nil
       uri.to_s
     end
  end

  def check_timestamp
    Time.at(header_options[:oauth_timestamp].to_i).to_datetime > nonce_expiration_seconds.seconds.ago
  end

  def nonce_expiration_seconds
    600 # 10 minutes
  end

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
