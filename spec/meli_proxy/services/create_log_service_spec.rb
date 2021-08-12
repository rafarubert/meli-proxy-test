# frozen_string_literal: true

describe CreateLogService do
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

      include_examples 'with allow_log_repository'

      it 'rescue LogError' do
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      end
    end

    context 'when exceeded attempts by ip' do
      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end
      let(:error_object) { { message: 'Invalid ip', status_code: 400 } }

      include_examples 'with allow_log_repository', 6, 1, 1

      it {
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      }
    end

    context 'when exceeded attempts by path' do
      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end
      let(:error_object) { { message: 'Invalid path', status_code: 400 } }

      include_examples 'with allow_log_repository', 1, 6, 1

      it {
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      }
    end

    context 'when exceeded attempts by ip and path' do
      let(:log_vo) do
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'
        )
      end
      let(:error_object) { { message: 'Invalid ip and path', status_code: 400 } }

      include_examples 'with allow_log_repository', 3, 3, 5

      it {
        expect { create_log_service }.to raise_error(
          an_instance_of(LogError).and(having_attributes(error_object))
        )
      }
    end
  end
end
