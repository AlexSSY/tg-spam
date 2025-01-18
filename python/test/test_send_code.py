import os
import pytest
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
        "phone_number": "spagetti"
    }

    response = requests.post("http://localhost:5000/send/code", json=payload)
    print(response.content)
    json_response = response.json()
    assert not response.ok
    assert not json_response["success"]
    assert json_response["error"] == "phone_invalid"
