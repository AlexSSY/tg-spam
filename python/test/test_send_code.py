import os
import time
import requests
from dotenv import load_dotenv


load_dotenv()


def test_valid_phone():
    payload = {
        "api_hash": os.getenv("API_HASH"),
        "app_id": os.getenv("APP_ID"),
        "phone_number": os.getenv("PHONE_NUMBER")
    }

    response = requests.post("http://localhost:5000/send/code", json=payload)
    json_response = response.json()
    assert response.ok
    assert json_response["success"]
    assert len(json_response["session"]) > 0
    assert len(json_response["phone_code_hash"]) > 0


def test_invalid_phone():
    payload = {
        "api_hash": os.getenv("API_HASH"),
        "app_id": os.getenv("APP_ID"),
        "phone_number": "100500"
    }

    response = requests.post("http://localhost:5000/send/code", json=payload)
    print(response.content)
    json_response = response.json()
    assert not response.ok
    assert not json_response["success"]
    assert json_response["error"] == "phone_invalid"


def test_valid_code():
    send_code_payload = {
        "api_hash": os.getenv("API_HASH"),
        "app_id": os.getenv("APP_ID"),
        "phone_number": os.getenv("PHONE_NUMBER")
    }

    send_code_response = requests.post("http://localhost:5000/send/code", json=send_code_payload)
    send_code_json_response = send_code_response.json()

    code = input("Enter code:")

    verify_code_payload = {
        "api_hash": os.getenv("API_HASH"),
        "app_id": os.getenv("APP_ID"),
        "phone_number": os.getenv("PHONE_NUMBER"),
        "phone_code_hash": send_code_json_response["phone_code_hash"],
        "code": code,
        "session": send_code_json_response["session"]
    }

    verify_code_response = requests.post("http://localhost:5000/verify/code", json=verify_code_payload)
    verify_code_json_response = verify_code_response.json()

    assert verify_code_response.ok
    assert verify_code_json_response["success"]
    assert len(verify_code_json_response["session"]) > 0


def test_invalid_code():
    send_code_payload = {
        "api_hash": os.getenv("API_HASH"),
        "app_id": os.getenv("APP_ID"),
        "phone_number": os.getenv("PHONE_NUMBER")
    }

    send_code_response = requests.post("http://localhost:5000/send/code", json=send_code_payload)
    send_code_json_response = send_code_response.json()

    time.sleep(3)

    verify_code_payload = {
        "api_hash": os.getenv("API_HASH"),
        "app_id": os.getenv("APP_ID"),
        "phone_number": os.getenv("PHONE_NUMBER"),
        "phone_code_hash": send_code_json_response["phone_code_hash"],
        "code": 00000,
        "session": send_code_json_response["session"]
    }

    verify_code_response = requests.post("http://localhost:5000/verify/code", json=verify_code_payload)
    verify_code_json_response = verify_code_response.json()

    assert not verify_code_response.ok
    assert not verify_code_json_response["success"]
    assert verify_code_json_response["error"] == "code_invalid"
