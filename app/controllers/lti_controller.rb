class LtiController < ApplicationController
  skip_before_action :verify_authenticity_token
  # TODO: Nonce verification

  def launch
    return head 401 unless authenticated?
    return head 403 unless check_timestamp
    return head 401 if params["context_id"].nil? || params["user_id"].nil?
    return head 401 if course.nil? || user.nil?

    log_in(user)
    redirect_to '/'
  end

  def config
    send_file("#{Rails.root}/app/assets/xml/url_config.xml",
              :filename => "url_config.xml",
              :disposition => "inline")
  end

  private

  def course
    @course ||= begin
      tmp_course = Course.find_by(course_id: params["context_id"])
      if tmp_course.nil?
        tmp_course = Course.new(course_params)
        tmp_course.save!
      end
      tmp_course
    end
  end

  def user
    puts User.last.inspect
    puts Student.last.inspect
    @user ||= begin
      tmp_user = User.find_by(canvas_id: params["user_id"], course_id: params["context_id"])
      if tmp_user.nil?
        tmp_user = User.new(user_params)
        tmp_user.save!
      end
      tmp_user
    end
  end

  def course_params
    {
      name: params["context_title"],
      course_id: params["context_id"]
    }
  end

  def user_params
    {
      name: params["lis_person_name_full"],
      canvas_id: params["user_id"],
      course: params["context_title"],
      course_id: params["context_id"],
      ta: params["roles"] != "Learner"
    }
  end

  def authenticated?
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
