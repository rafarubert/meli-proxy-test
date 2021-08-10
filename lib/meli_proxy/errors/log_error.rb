class LogError < StandardError
  attr_reader :status_code

  def initialize(msg = 'Invalid Log', status_code = 500)
    @status_code = status_code
    super(msg)
  end
end
