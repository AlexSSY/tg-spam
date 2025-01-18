import asyncio
from telethon.sync import TelegramClient
from telethon.sessions import StringSession
from telethon.errors import (
    SessionPasswordNeededError,
    PhoneCodeInvalidError,
    PhoneCodeExpiredError,
    PhoneNumberInvalidError,
    PhoneNumberUnoccupiedError,
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
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client.disconnect()
