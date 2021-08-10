# frozen_string_literal: true

class RedirectService
  def call(log)
    CreateLogService.new.call(log)

    MeliProxy::REDIRECT_URL + log.fullpath
  end
end
