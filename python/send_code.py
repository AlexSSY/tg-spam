from telethon.errors import (
    PhoneNumberInvalidError,
    PhoneNumberBannedError,
    FloodWaitError,
    PhoneNumberUnoccupiedError,
    SessionPasswordNeededError
)
from telethon.sync import TelegramClient
from telethon.sessions import StringSession
import asyncio


def send_code(app_id, api_hash, phone_number):
    loop = asyncio.new_event_loop() # create an event loop for TelegramClient
    asyncio.set_event_loop(loop)
    client = TelegramClient(StringSession(), int(app_id), api_hash)

    try:
        client.connect()
        sent_code = client.send_code_request(phone_number)

        return {
            "success": True,
            "session": client.session.save(),
            "phone_code_hash": sent_code.phone_code_hash
        }
    except ValueError as e:
        # Cause: If the provided phone number is invalid or not formatted correctly.
        # Example: Passing a phone number without the country code.
        return {
            "success": False,
            "error": "phone_invalid",
            "detail": e.__str__()
        }
    except PhoneNumberInvalidError as e:
        # Cause: The phone number is not recognized by Telegram.
        return {
            "success": False,
            "error": "phone_invalid",
            "detail": e.message
        }
    except PhoneNumberBannedError as e:
        # Cause: The phone number is banned from using Telegram.
        return {
            "success": False,
            "error": "phone_banned",
            "detail": e.message
        }
    except FloodWaitError as e:
        # Cause: Too many requests in a short time; wait for the specified time before retrying.
        return {
            "success": False,
            "error": "flood_wait",
            "detail": e.message
        }
    except PhoneNumberUnoccupiedError as e:
        # Cause: The phone number is not associated with any Telegram account (for login purposes).
        return {
            "success": False,
            "error": "phone_unoccupied",
            "detail": e.message
        }
    except SessionPasswordNeededError as e:
        # Cause: When two-factor authentication is enabled for the account, this exception will be raised.
        return {
            "success": False,
            "error": "two_factor",
            "detail": e.message
        }
    finally:
        client.disconnect()
