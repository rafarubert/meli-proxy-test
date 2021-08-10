# frozen_string_literal: true

class CreateLogValidation
  def validates_log(log)
    call_error 'Invalid redirect', 400 if log.ip.blank? || log.path.blank?
  end

  def validate_log_creation(log, count_ip, count_path, count_ip_path)
    validates_redirect log
    validates_ip count_ip
    validates_path count_path
    validates_ip_path count_ip_path
  end

  private

  def call_error(message, status_code)
    raise(LogError.new(message, status_code))
  end

  def validates_redirect(log)
    call_error 'Invalid redirect', 400 if log.ip.blank? || log.path.blank?
  end

  def validates_ip(count_ip)
    return if count_ip < MeliProxy::MAX_IP

    call_error 'Invalid ip', 400
  end

  def validates_path(count_path)
    return if count_path < MeliProxy::MAX_PATH

    call_error('Invalid path', 400)
  end

  def validates_ip_path(count_ip_path)
    return if count_ip_path < MeliProxy::MAX_IP_PATH

    call_error 'Invalid ip and path', 400
  end
end
