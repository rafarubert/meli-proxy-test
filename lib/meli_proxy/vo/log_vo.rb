# frozen_string_literal: true

class LogVo
  attr_reader :ip, :path, :fullpath

  def initialize(params = {})
    @ip = params[:ip]
    @path = params[:path]
    @fullpath = params[:fullpath]
  end
end
