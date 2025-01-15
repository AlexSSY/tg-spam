import sys
import yaml
from telethon.sync import TelegramClient
from telethon.sessions import StringSession


def main():
    argv = sys.argv[1:]
    app_id, api_hash, session = argv

    client = TelegramClient(StringSession(session), int(app_id), api_hash)

    try:
        # Start the client (this will check if the session is valid)
        client.connect()

        # Check if the client is authorized (authenticated)
        if client.is_user_authorized():
            print(True)
        else:
            print(False)
    except Exception as e:
        # Handle any exceptions (invalid session or connection issues)
        print(False)
    finally:
        client.disconnect()


if __name__ == "__main__":
    main()
