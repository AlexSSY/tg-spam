import sys
import yaml
from telethon.sync import TelegramClient
from telethon.sessions import StringSession


def main():
    argv = sys.argv[1:]
    app_id, api_hash, phone_number = argv

    client = TelegramClient(StringSession(), int(app_id), api_hash)

    try:
        client.connect()
        sent_code = client.send_code_request(phone_number)

        data_to_expose = {"session": client.session.save(
        ), "phone_code_hash": sent_code.phone_code_hash}

        yaml_data = yaml.dump(data_to_expose)

        print(yaml_data)
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client.disconnect()


if __name__ == "__main__":
    main()
