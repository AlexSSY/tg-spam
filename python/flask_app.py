from flask import Flask, request, jsonify
from . import send_code


app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"


@app.route("/send/code", methods=["POST"])
def send_code():
    data = request.get_json()
    api_hash = data.get("api_hash")
    app_id = data.get("app_id")
    phone_number = data.get("phone_number")

    # Process the data
    result = send_code.send_code(app_id, api_hash, phone_number)

    # Return a JSON response
    return jsonify(result)


if __name__ == "__main__":
    app.run(debug=True)
