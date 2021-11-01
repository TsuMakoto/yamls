# frozen_string_literal: true

require "active_support"

module Yamls
  module Support
    module Parameters
      extend ActiveSupport::Concern

      included do
        before_action :define_params_method
      end

      protected

      def yamls
        Yamls::Parameters.new(
          params,
          model: controller_name.singularize,
          action: action_name,
        ).permit
      end

      def define_params_method
        method_name = "#{controller_name.singularize}_#{action_name}_params"

        define_singleton_method(method_name) { yamls }
      end
    end
  end
end
