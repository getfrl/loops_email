
class LoopsEmail::Client
  def initialize; end

  def post(endpoint, body: {}, other_headers: {})
    return if LoopsEmail.stub?

    response = Net::HTTP.post(
      endpoint_uri(endpoint),
      body.to_json,
      headers.merge(other_headers)
    )
    log_response(response)
    LoopsEmail::Result.new(response)
  end

  def get(endpoint, other_headers: {})
    return if LoopsEmail.stub?

    response = Net::HTTP.get(
      endpoint_uri(endpoint),
      headers.merge(other_headers)
    )
    log_response(response)
    LoopsEmail::Result.new(response)
  end

  private

  def success?(response)
    response.is_a? Net::HTTPSuccess
  end

  def log_response(response)
    if response.is_a? Net::HTTPSuccess
      LoopsEmail.logger.info "[LoopsEmail] send email success: #{response.body}"
    else
      LoopsEmail.logger.error "[LoopsEmail] send email failed: #{response.body}"
    end
  end

  def endpoint_uri(endpoint)
    slash = endpoint.start_with?('/') ? '' : '/'
    URI("#{LoopsEmail::Configuration::API_HOST}#{slash}#{endpoint}")
  end

  def headers
    {
      "Authorization": "Bearer #{api_key}",
      "Content-Type": 'application/json'
    }
  end

  def api_key
    LoopsEmail.api_key ||
      ENV["LOOPS_EMAIL_API_KEY"] ||
      raise(LoopsEmail::Error.new("api_key is not set"))
  end
end