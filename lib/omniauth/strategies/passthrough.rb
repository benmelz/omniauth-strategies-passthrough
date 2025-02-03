# frozen_string_literal: true

require 'omniauth'
require 'rack/utils'

module OmniAuth
  module Strategies
    # :nodoc:
    class Passthrough
      include OmniAuth::Strategy

      def request_phase
        redirect(URI.parse(callback_url).tap { |uri| uri.query = Rack::Utils.build_nested_query(request.params) }.to_s)
      end

      uid { request.params['uid'] }
      info { request.params['info'] || {} }
    end
  end
end
