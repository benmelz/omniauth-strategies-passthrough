# frozen_string_literal: true

require 'omniauth/strategies/passthrough'
require 'rack'
require 'rack/session'
require 'rack/test'

RSpec.describe OmniAuth::Strategies::Passthrough do
  it 'defines a version constant' do
    expect(described_class::VERSION).not_to be_nil
  end

  describe 'POSTing to the callback endpoint' do
    include Rack::Test::Methods

    subject(:authenticate) do
      post '/auth/passthrough', params
      follow_redirect!
    end

    let(:app) { Rack::Session::Cookie.new described_class.new(->(_) { [200, {}, ''] }), secret: 'test' * 16 }
    let(:auth) { last_request.env['omniauth.auth'] }

    before { allow(OmniAuth.config).to receive(:request_validation_phase).and_return(nil) }

    context 'without auth params' do
      let(:params) { {} }

      it 'sets the omniauth env with a nil uid' do
        authenticate
        expect(auth.uid).to be_nil
      end

      it 'sets the omniauth env with a blank info hash' do
        authenticate
        expect(auth.info).to eq({})
      end
    end

    context 'with auth params' do
      let(:params) { { uid: '123-uid', info: { 'whatever' => 'you want', 'gets' => 'forwarded' } } }

      it 'sets the omniauth env with the forwarded uid' do
        authenticate
        expect(auth.uid).to eq(params[:uid])
      end

      it 'sets the omniauth env with the forwarded info hash' do
        authenticate
        expect(auth.info).to eq(params[:info])
      end
    end
  end
end
