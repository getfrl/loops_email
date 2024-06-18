
class LoopsEmail::Result
  attr_accessor :response

  def initialize(response)
    @response = response
  end

  def success?
    response_success? && operation_success?
  end

  def failed?
    !success?
  end

  def response_success?
    response.is_a? Net::HTTPSuccess
  end

  def operation_success?
    body.dig(:body, :success)
  end

  def http_code
    response.code
  end

  def message
    body[:content] || body.dig(:error, :message) || body
  end

  def error
    body[:error]
  end

  def body
    JSON.parse(response.body, symbolize_names: true)
  rescue JSON::ParserError
    { content: response.body }
  end

  def as_json
    {
      success: success?,
      http_code: http_code,
      body: body
    }
  end
  alias to_h as_json
end