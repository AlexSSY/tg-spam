import asyncio
from telethon.sync import TelegramClient
from telethon.sessions import StringSession


def chats(app_id, api_hash, session):
    loop = asyncio.new_event_loop() # create an event loop for TelegramClient
    asyncio.set_event_loop(loop)
    client = TelegramClient(StringSession(session), int(app_id), api_hash)

    try:
        client.connect()
        dialogs = client.get_dialogs(archived=False)

        return {
            "success": True,
            "chats": map(lambda x: x.title, dialogs)
        }
    except Exception as e:
        return {
            "success": False,
            "error": "unknown",
            "detail": e
        }
    finally:
        client.disconnect()
