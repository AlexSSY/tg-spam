import asyncio
from telethon.sync import TelegramClient
from telethon.sessions import StringSession
from telethon.errors import (
    SessionPasswordNeededError,
    PhoneCodeInvalidError,
    PhoneCodeExpiredError,
    FloodWaitError
)


def verify_code(app_id, api_hash, phone_number, phone_code_hash, code, session):
    loop = asyncio.new_event_loop() # create an event loop for TelegramClient
    asyncio.set_event_loop(loop)
    client = TelegramClient(StringSession(session), int(app_id), api_hash)

    try:
        client.connect()
        client.sign_in(phone=phone_number, phone_code_hash=phone_code_hash, code=code)

        return {
            "success": True,
            "session": client.session.save()
        }
    except SessionPasswordNeededError as e:
        return {
            "success": False,
            "error": "password_needed",
            "detail": e.message
        }
    except PhoneCodeInvalidError as e:
        return {
            "success": False,
            "error": "code_invalid",
            "detail": e.message
        }
    except PhoneCodeExpiredError as e:
        return {
            "success": False,
            "error": "code_expired",
            "detail": e.message
        }
    except FloodWaitError as e:
        return {
            "success": False,
            "error": "flood_wait",
            "detail": e.seconds
        }
    except Exception as e:
        return {
            "success": False,
            "error": "unknown",
            "detail": e.__str__()
        }
    finally:
        client.disconnect()
