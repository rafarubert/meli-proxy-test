class LogRepository
  def initialize
    @log = Log
  end

  def create(ip, path)
    @log.create(
      ip: ip,
      path: path
    )
  end

  def count_ip ip
    @log.where(ip: ip).count
  end

  def count_path path
    @log.where(path: path).count
  end

  def count_ip_path ip, path
    @log.where(ip: ip, path: path).count
  end
end
