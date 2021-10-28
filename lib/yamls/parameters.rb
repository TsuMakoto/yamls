require_relative "./yml_load"

class Parameter
  def initialize(params, *model, action: :regist, filepath: "app/parameters/column.yml")
    @params        = params
    @require_model = model.last
    @action        = action
    @columns       = yml_loader.load(filepath).dig(*model, action)
  end

  def permit
    params.require(require_model).permit(*columns)
  end

  private

  attr_reader :columns, :require_model, :params, :action

  def yml_loader
    @yml_loader ||= YmlLoad.new
  end
end
