class LtiController < ApplicationController
  skip_before_action :verify_authenticity_token
  # TODO: Nonce verification

  def launch
    return head 401 unless authenticated?
    return head 403 unless check_timestamp
    redirect_to '/'
  end

  def config
    send_file("#{Rails.root}/app/assets/xml/url_config.xml",
              :filename => "url_config.xml",
              :disposition => "inline")
  end

  private

  def authenticated?
    # TODO: Ask William about Keys
    authenticator = IMS::LTI::Services::MessageAuthenticator.new(url, header_options, 'secret')
    authenticator.valid_signature?
  end

  def header_options
    @header_options ||= begin
      options = params.to_unsafe_hash.deep_symbolize_keys
      options.delete(:action)
      options.delete(:controller)
      options
    end
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
end
