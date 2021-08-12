# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CreateLogService do
  subject(:create_log_service) { described_class.new.call(log_vo) }

  describe '.call' do
    context 'when valid log' do
      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end

      it { expect { create_log_service }.not_to raise_error }
    end

    context 'when not valid' do
      let(:log_vo) { LogVo.new }
      let(:error_object) { { message: 'Invalid redirect', status_code: 400 } }

      it 'rescue LogError' do
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      end
    end
  end
end
