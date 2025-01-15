require "debug"
require "yaml"
require "dotenv/load"
require_relative "python"


def main
  phone_number = "380962089514"
  send_code_data = YAML.safe_load run_tg_py("send_code", phone_number)
  puts send_code_data
  puts ""
  puts "Enter code:"
  code = gets.chomp
  session_data = run_tg_py("verify_code", phone_number, send_code_data["phone_code_hash"], code, send_code_data["session"])
  puts ""
  puts session_data
end

# main
session_string = "1ApWapzMBu4xqEBZ2Fa_Ty4ONkZozNlI6IEY_0igHZ_dzbVP5Qy1lJCuofWIqDE4vGnzfu41HvhGeIJtelOGIx_7-V2r3gQuBqIAeHRT9QXab2IARPXiAdB2flxFUg3NRdzZDgSU81sVLvwAsYEXiM7R8f52uWjHUibk2N4hIP1_sJoVNjDQxFLnwyFjbAQ5bU-7KZZr6zqLpY-yiMgmsPpzPIos3yqmubb5mGNkk7JUZVr42tOdL7YxuK8r7Mg4DfW_bGei43RElRfrkzxkh664McCpU9Lf4oJoAU_tW2AF-p_OA1PPc17b7OKLcZznCOfwcb3qx-_dEas1uOWMD1xYlKAe6zPA="
puts run_tg_py("check_authentication", session_string)
puts run_tg_py("send_image", session_string, "mika")