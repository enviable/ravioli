# frozen_string_literal: true

module Ravioli
  class Engine < ::Rails::Engine
    # Bootstrap Ravioli onto the Rails app
    initializer "ravioli", before: :load_config_initializers do |app|
      Rails.extend Ravioli::RailsConfig unless Rails.respond_to?(:config)
    end
  end

  private

  module RailsConfig
    def config
      Ravioli.default || Ravioli.build(namespace: Rails.application&.class&.module_parent, strict: Rails.env.production?) do |config|
        config.add_staging_flag!
        config.auto_load_files!
        config.auto_load_credentials!
      end
    end
  end
end
