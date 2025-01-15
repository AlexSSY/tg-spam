import sys
import yaml
from telethon.sync import TelegramClient
from telethon.sessions import StringSession


def main():
    argv = sys.argv[1:]
    app_id, api_hash, session, message = argv

    client = TelegramClient(StringSession(session), int(app_id), api_hash)

    try:
        client.connect()
        client.send_file("me", "./qop.jpg", caption=message)
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client.disconnect()


if __name__ == "__main__":
    main()
