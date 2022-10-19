# frozen_string_literal: true

require_relative "yondu/version"

module Yondu
  class Error < StandardError; end

  class MissingSetting < Error
    def initialize(keys)
      super("Missing setting: #{keys.join('->')}")
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
        scope << key
        value = value.fetch(key) { raise MissingSetting.new(keys) }
      end

      value
    end
  end
end
