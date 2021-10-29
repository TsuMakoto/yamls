module Yamls
  class YamlLoad
    def initialize(basepath = Rails.root, loader: YAML)
      @basepath = basepath
      @loader   = loader
    end

    def load(filepath)
      @loader.load_file("#{@basepath}/#{filepath}")
    end
  end
end
