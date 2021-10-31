# frozen_string_literal: true

require_relative "../yamls/parameters"

module Yamls
  module Support
    module Parameters
      extend ActiveSupport::Concern

      def yamls
        Yamls::Parameters.new(
          params,
          model: controller_name.singularize,
          action: action_name,
        ).permit
      end
    end
  end
end
