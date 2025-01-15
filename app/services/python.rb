require "open3"

class Python
  def self.run_py(path, *args)
    command = [ "./python/.venv/bin/python", "./python/#{path}.py", *args ]
    stdout, stderr, status = Open3.capture3(*command)

    if status.success?
      stdout.strip  # Return the standard output
    else
      raise "Error running #{path}.py: #{stderr.strip}"  # Raise an error with stderr
    end
  end

  def self.run_tg_py(path, *args)
    app_id = Rails.application.credentials.telegram.app_id
    api_hash = Rails.application.credentials.telegram.api_hash
    raise "Environment variables APP_ID or API_HASH not set" unless app_id && api_hash

    run_py(path, app_id.to_i.to_s, api_hash, *args)
  end
end
