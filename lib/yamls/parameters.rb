require_relative "./yaml_load"

module Yamls
  class Parameters
    def initialize(
      params,
      model:,
      action:,
      required: nil,
      nested: [],
      filepath: "app/parameters/column.yml"
    )
      @params   = params
      @required = required || @model
      @columns  = yml_loader.load(filepath).dig(model, *nested.push(action))
    end

    def permit
      params.require(required).permit(*columns)
    end

    private

    attr_reader :params, :required, :columns

    def yaml_loader
      @yaml_loader ||= YamlLoad.new
    end
  end
end
