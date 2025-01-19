from flask import Flask, request, jsonify, make_response
from send_code import send_code as t_send_code
from verify_code import verify_code as t_verify_code
from chats import chats as t_chats


app = Flask(__name__)


@app.route("/send/code", methods=["POST"])
def send_code():
    data = request.get_json()
    api_hash = data.get("api_hash")
    app_id = data.get("app_id")
    phone_number = data.get("phone_number")

    # Process the data
    result = t_send_code(app_id, api_hash, phone_number)
    
    # Return a JSON response
    return make_response(jsonify(result), 200 if result["success"] else 401)


@app.route("/verify/code", methods=["POST"])
def verify_code():
    data = request.get_json()
    api_hash = data.get("api_hash")
    app_id = data.get("app_id")
    phone_number = data.get("phone_number")
    phone_code_hash = data.get("phone_code_hash")
    code = data.get("code")
    session = data.get("session")

    # Process the data
    result = t_verify_code(app_id, api_hash, phone_number, phone_code_hash, code, session)

    # Return a JSON response
    return make_response(jsonify(result), 200 if result["success"] else 401) 


@app.route("/chats")
def chats():
    data = request.get_json()
    api_hash = data.get("api_hash")
    app_id = data.get("app_id")
    session = data.get("session")

    result = t_chats(app_id, api_hash, session)
    return make_response(jsonify(result), 200 if result["success"] else 401) 


if __name__ == "__main__":
    app.run(debug=True)
