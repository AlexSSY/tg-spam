class AccountsController < ApplicationController
  require "httparty"

  before_action :authenticate_user!
  before_action :set_account, only: %i[show destroy]

  def index
  end

  def show
  end

  def new
    # renders a phone inout form
    @code_request = CodeRequest.new
  end

  def send_code
    @code_request = CodeRequest.new request_code_params do |record|
      record.user_id = current_user.id
    end

    sleep 1 # TODO delete this
    if @code_request.save
      request_body = body_with_credentials({
        phone_number: @code_request.phone
      })

      response = HTTParty.post(
        url + "/send/code",
        headers: { "Content-Type" => "application/json" },
        body: request_body.to_json
      )

      json_response = JSON.parse response.body

      if response.success?
        session[:phone_code_hash] = json_response["phone_code_hash"]
        session[:phone_number] = @code_request.phone
        session[:session_string] = json_response["session"]
        redirect_to authenticate_accounts_path
      else
        @code_request = CodeRequest.new

        case json_response["error"]
        when "phone_invalid"
          @code_request.errors.add(:phone, "phone number not valid")
        else
          @code_request.errors.add(:phone, "unexpected error")
        end

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
    request_body = body_with_credentials({
      phone_number: session[:phone_number],
      phone_code_hash: session[:phone_code_hash],
      code: attempt_code_params[:code],
      session: session[:session_string]
    })

    response = HTTParty.post(
      url + "/verify/code",
      headers: { "Content-Type" => "application/json" },
      body: request_body.to_json
    )

    json_response = JSON.parse response.body

    if response.success?
      Account.create(user_id: current_user.id,
        phone: request_body[:phone_number],
        session_data: json_response["session"]
      )
      redirect_to accounts_path
    else
      @code_attempt = CodeAttempt.new

      case json_response["error"]
      when "code_invalid"
        @code_attempt.errors.add(:code, "code is not valid")
      else
        @code_attempt.errors.add(:code, "unexpected error")
      end

      render :authenticate, status: :unprocessable_entity
    end
  end

  def destroy
    if @account.present?
      @account.destroy
      redirect_to accounts_path
    else
      redirect_to accounts_path
    end
  end

  private

  def body_with_credentials(extra_hash)
    {
      app_id: Rails.application.credentials.telegram.app_id,
      api_hash: Rails.application.credentials.telegram.api_hash
    }.merge extra_hash
  end

  def url
    "http://localhost:5000"
  end

  def request_code_params
    params.require(:code_request).permit(:phone)
  end

  def attempt_code_params
    params.require(:code_attempt).permit(:code)
  end

  def set_account
    @account = Account.find params[:id]
  end
end
