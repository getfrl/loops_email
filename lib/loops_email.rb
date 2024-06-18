# frozen_string_literal: true

require_relative "loops_email/version"
require_relative "loops_email/error"
require_relative "loops_email/configuration"
require_relative "loops_email/result"
require_relative "loops_email/client"
require_relative "loops_email/sdk"
require_relative "loops_email/sdk/transactional_email"

module LoopsEmail
  class << self
    def configure
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def api_key
      configuration.api_key
    end

    def stub?
      configuration.stub?
    end

    def logger
      @looger ||= if ENV["RAILS_LOG_TO_STDOUT"] || ENV["LOOPS_EMAIL_LOG_TO_STDOUT"]
                    Logger.new(STDOUT)
                  else
                    Logger.new(configuration.log_file_path)
                  end
    end
  end
end
