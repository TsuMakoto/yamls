# frozen_string_literal: true
require_relative "./helpers/config"
require_relative "./helpers/yaml_load"

module Yamls
  class Parameters
    def initialize(
      params,
      model: nil,
      action: nil,
      required: nil,
      nested: [],
      filepath: "#{Rails.root}/#{Helpers::FILEPATH}"
    )
      @params   = params
      @required = required || model
      @nested   = [model, action].push(*nested).compact.map(&:to_s)
      @filepath = filepath
    end

    def permit
      return params.permit(columns) if required.nil?

      params.require(required).permit(columns)
    end

    private

    attr_reader :params, :filepath, :required, :nested

    def yaml_loader
      @yaml_loader ||= Helpers::YamlLoad.new(filepath)
    end

    def columns
      yaml_loader.load.dig(*nested)
    end
  end
end
