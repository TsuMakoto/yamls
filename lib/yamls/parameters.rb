# frozen_string_literal: true
require_relative "./config"
require_relative "./yaml_load"

module Yamls
  class Parameters
    def initialize(
      params,
      model: nil,
      action: nil,
      required: nil,
      nested: [],
      filepath: "#{Rails.root}/#{Yamls::FILEPATH}"
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
      @yaml_loader ||= YamlLoad.new(filepath)
    end

    def columns
      yaml_loader.load.dig(*nested)
    end
  end
end
