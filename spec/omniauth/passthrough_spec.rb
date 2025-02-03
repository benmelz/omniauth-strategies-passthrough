# frozen_string_literal: true

require 'omniauth/passthrough'

RSpec.describe OmniAuth::Passthrough do
  it 'defines a version constant' do
    expect(described_class::VERSION).not_to be_nil
  end
end
