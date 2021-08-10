# frozen_string_literal: true

class CreateLogService
  def initialize
    @log_repository = LogRepository.new
    @log_validation = CreateLogValidation.new
  end

  def call(log)
    @log_validation.validates_log(log)

    count_ip = @log_repository.count_ip log.ip
    count_path = @log_repository.count_path log.path
    count_ip_path = @log_repository.count_ip_path log.ip, log.path

    @log_validation.validate_log_creation(
      log, count_ip, count_path, count_ip_path
    )

    @log_repository.create(
      log.ip, log.path
    )
  end
end
