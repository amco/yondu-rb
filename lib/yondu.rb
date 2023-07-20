# frozen_string_literal: true

require_relative "yondu/version"

module Yondu
  class Error < StandardError; end

  class MissingSettingError < Error
    def initialize(scope)
      super("Missing setting: #{scope.join('->')}")
    end
  end

  class NoHashSettingError < Error
    def initialize(scope)
      super("No hash setting: #{scope.join('->')}")
    end
  end

  class Settings
    def initialize(config)
      @config = config
    end

    def get(*keys)
      scope = []
      value = @config

      keys.each do |key|
        raise NoHashSettingError.new(scope) unless value.is_a?(Hash)
        scope << key
        value = value.fetch(key) { raise MissingSettingError.new(scope) }
      end

      value
    end
  end
end
