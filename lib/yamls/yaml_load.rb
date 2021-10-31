# frozen_string_literal: true
module Yamls
  class YamlLoad
    def initialize(filepath, loader: YAML)
      @filepath = filepath
      @loader   = loader
    end

    def load
      loader.load_file(filepath)
    end

    private

    attr_reader :filepath, :loader
  end
end
