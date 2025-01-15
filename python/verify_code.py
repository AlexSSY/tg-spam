import sys
from telethon.sync import TelegramClient
from telethon.sessions import StringSession


def main():
    argv = sys.argv[1:]
    app_id, api_hash, phone_number, phone_code_hash, code, session = argv
    
    client = TelegramClient(StringSession(session), int(app_id), api_hash)

    try:
        client.connect()
        client.sign_in(phone=phone_number, phone_code_hash=phone_code_hash, code=code)
        print(client.session.save())
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client.disconnect()

if __name__ == "__main__":
    main()
