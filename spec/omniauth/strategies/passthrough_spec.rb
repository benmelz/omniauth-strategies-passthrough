# frozen_string_literal: true

require 'omniauth/strategies/passthrough'
require 'rack'
require 'rack/test'

RSpec.describe OmniAuth::Strategies::Passthrough do
  include Rack::Test::Methods

  let(:app) { Rack::Session::Cookie.new described_class.new(->(_) { [200, {}, ''] }), secret: 'test' }

  describe 'POST /auth/passthrough' do
    subject(:authenticate) do
      post '/auth/passthrough', params
      follow_redirect!
    end

    let(:auth) { last_request.env['omniauth.auth'] }

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
