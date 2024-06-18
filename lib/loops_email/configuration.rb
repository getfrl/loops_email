
class LoopsEmail::Configuration
  attr_writer :api_key, :stub, :log_file_path

  API_HOST = "https://app.loops.so"

  class Error < LoopsEmail::Error; end

  def initialize; end

  def api_key
    @api_key || ENV["LOOPS_EMAIL_API_KEY"] || raise(LoopsEmail::Configuration::Error.new("api_key is not set"))
  end

  def log_file_path
    @log_file_path || "log/loops_email.log"
  end

  def stub
    @stub || false
  end
  alias stub? stub
end