# frozen_string_literal: true

shared_context 'with allow_log_repository' do |count_ip, count_path, count_ip_path|
  let(:log_repository_instance) { instance_double(LogRepository) }

  before do
    allow(LogRepository).to receive(:new).and_return(log_repository_instance)
    allow(log_repository_instance).to receive(:count_ip).with(log_vo.ip).and_return(count_ip)
    allow(log_repository_instance).to receive(:count_path).with(log_vo.path).and_return(count_path)
    allow(log_repository_instance).to receive(:count_ip_path).with(log_vo.ip, log_vo.path).and_return(count_ip_path)
  end
end
