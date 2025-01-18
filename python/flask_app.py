from flask import Flask, request, jsonify


app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"


@app.route("/send/code", methods=["POST"])
def send_code():
    if request.is_json:
        data = request.get_json()


if __name__ == "__main__":
    app.run(debug=True)
