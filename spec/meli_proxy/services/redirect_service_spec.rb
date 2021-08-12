# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RedirectService do
  subject(:redirect_service) { described_class.new.call(log_vo) }

  describe '.call' do
    let(:log_service_instance) { instance_double(CreateLogService) }

    context 'when valid log' do
      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end

      before do
        allow(CreateLogService).to receive(:new).and_return(log_service_instance)
        allow(log_service_instance).to receive(:call).with(log_vo)
      end

      it 'call created_log instance' do
        redirect_service

        expect(log_service_instance).to have_received(:call)
      end

      it 'return correct redirect url' do
        expect(redirect_service).to eq 'https://api.mercadolibre.com/start'
      end
    end
  end
end
