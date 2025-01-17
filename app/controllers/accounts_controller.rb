class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    # renders a phone inout form
    @code_request = CodeRequest.new
  end

  def send_code
    @code_request = CodeRequest.new request_code_params do |record|
      record.user_id = current_user.id
    end
    sleep 5
    if @code_request.save
      begin
        raw_result = Python.run_tg_py "send_code", @code_request.phone
        hash_result = YAML.safe_load raw_result
        session[:phone_code_hash] = hash_result["phone_code_hash"]
        session[:phone_number] = @code_request.phone
        session[:session_string] = hash_result["session"]
        redirect_to authenticate_accounts_path
      rescue Exception => e
        @code_request = CodeRequest.new
        @code_request.errors.add(:phone, e)
        render :new, status: :unprocessable_entity
      end
    else
      # is invalid
      render :new, status: :unprocessable_entity
    end
  end

  def authenticate
    # renders a code inout form
    @code_attempt = CodeAttempt.new
  end

  def create
    phone_number = session[:phone_number]
    phone_code_hash = session[:phone_code_hash]
    code = attempt_code_params[:code]
    session_string = session[:session_string]

    begin
      result = Python.run_tg_py "verify_code", phone_number, phone_code_hash, code, session_string
      Account.create user_id: current_user.id, phone: phone_number, session_data: result
    rescue Exception => e
      @code_attempt = CodeAttempt.new
      @code_attempt.errors.add("code", e)
      render :authenticate, status: :unprocessable_entity
    end
  end

  private

  def request_code_params
    params.require(:code_request).permit(:phone)
  end

  def attempt_code_params
    params.require(:code_attempt).permit(:code)
  end
end
