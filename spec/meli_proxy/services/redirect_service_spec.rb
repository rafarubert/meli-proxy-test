require 'spec_helper'

RSpec.describe RedirectService do
  describe '.call' do
    context 'valid log' do
      let(:log_vo){
        LogVo.new(
          ip: '127.0.0.1',
          path: '/start',
          fullpath: '/start'  
        )
      }

      before do
        expect_any_instance_of(CreateLogService).to receive(:call)
      end

      it 'call CreateLogService' do
        expect(subject.call(log_vo)).to eq 'https://api.mercadolibre.com/start'   
      end
    end


  end
end