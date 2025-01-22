import asyncio
from telethon.sync import TelegramClient
from telethon.sessions import StringSession


def chats(app_id, api_hash, session, image, text):
    loop = asyncio.new_event_loop() # create an event loop for TelegramClient
    asyncio.set_event_loop(loop)
    client = TelegramClient(StringSession(session), int(app_id), api_hash)

    try:
        client.connect()
        dialogs = client.get_dialogs(archived=False)
        for dialog in dialogs:
            client.send_file(dialog, "./qop.jpg", caption=text)
        
        return {
            "success": True,
            "total_sent": len(dialogs)
        }
    except Exception as e:
        return {
            "success": False,
            "error": "unknown",
            "detail": e
        }
    finally:
        client.disconnect()
