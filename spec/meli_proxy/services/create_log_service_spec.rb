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

    context 'when exceeded attempts by ip' do
      let(:log_repository_instance) { instance_double(LogRepository) }
      let(:error_object) { { message: 'Invalid ip', status_code: 400 } }

      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end

      before do
        allow(LogRepository).to receive(:new).and_return(log_repository_instance)
        allow(log_repository_instance).to receive(:count_ip).with(log_vo.ip).and_return(6)
        allow(log_repository_instance).to receive(:count_path).with(log_vo.path).and_return(1)
        allow(log_repository_instance).to receive(:count_ip_path).with(log_vo.ip, log_vo.path).and_return(1)
      end

      it {
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      }
    end

    context 'when exceeded attempts by path' do
      let(:log_repository_instance) { instance_double(LogRepository) }
      let(:error_object) { { message: 'Invalid path', status_code: 400 } }

      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end

      before do
        allow(LogRepository).to receive(:new).and_return(log_repository_instance)
        allow(log_repository_instance).to receive(:count_ip).with(log_vo.ip).and_return(1)
        allow(log_repository_instance).to receive(:count_path).with(log_vo.path).and_return(6)
        allow(log_repository_instance).to receive(:count_ip_path).with(log_vo.ip, log_vo.path).and_return(1)
      end

      it {
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      }
    end

    context 'when exceeded attempts by ip and path' do
      let(:log_repository_instance) { instance_double(LogRepository) }
      let(:error_object) { { message: 'Invalid ip and path', status_code: 400 } }

      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end

      before do
        allow(LogRepository).to receive(:new).and_return(log_repository_instance)
        allow(log_repository_instance).to receive(:count_ip).with(log_vo.ip).and_return(3)
        allow(log_repository_instance).to receive(:count_path).with(log_vo.path).and_return(3)
        allow(log_repository_instance).to receive(:count_ip_path).with(log_vo.ip, log_vo.path).and_return(5)
      end

      it {
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      }
    end
  end
end
