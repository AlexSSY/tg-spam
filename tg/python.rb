require 'open3'

def run_py(path, *args)
  command = [".venv/bin/python", "./python/#{path}.py", *args]
  stdout, stderr, status = Open3.capture3(*command)
  
  if status.success?
    stdout.strip  # Return the standard output
  else
    raise "Error running #{path}.py: #{stderr.strip}"  # Raise an error with stderr
  end
end

def run_tg_py(path, *args)
  app_id = ENV["APP_ID"]
  api_hash = ENV["API_HASH"]
  raise "Environment variables APP_ID or API_HASH not set" unless app_id && api_hash

  run_py(path, app_id.to_i.to_s, api_hash, *args)
end

def main
  begin
    result = run_py("send_code", "380962089514")
    puts "Result: #{result}"
  rescue => e
    puts "Error: #{e.message}"
  end
end
