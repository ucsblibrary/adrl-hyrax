# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  include Blacklight::Controller
  include Hydra::Controller::ControllerBehavior
  include Hyrax::Controller
  include Hyrax::ThemedLayoutController

  with_themed_layout "1_column"

  protect_from_forgery with: :exception
end
