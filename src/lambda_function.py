import boto3
import os
import json
import hvac
import base64


def lambda_handler(event, context):
    print("----------------------------------")
    read_from_secrets_file()
    print("----------------------------------")

    hvac_client = connect_to_local_proxy()
    print(("----------------------------------"))

    read_secrets_from_client_proxy(client=hvac_client)
    print("----------------------------------")

    transit_from_client_proxy(client=hvac_client)
    print("----------------------------------")

    return {
        "statusCode": 200,
        "body": "success"
    }


def connect_to_local_proxy():
    proxy_url = "http://localhost:8200"
    print(f"Connecting to local proxy {proxy_url}...")

    hvac_client = hvac.Client(url=proxy_url, namespace=os.getenv("VAULT_NAMESPACE"))
    print("Token Lookup:")
    print(hvac_client.lookup_token())

    return hvac_client


def read_secrets_from_client_proxy(client):
    print("Reading from proxy...")
    kv2 = client.secrets.kv.v2.read_secret(mount_point="demo-kvv2", path="demo-secret")
    print(kv2.get("data").get("data"))


def transit_from_client_proxy(client):
    print("Encrypting using transit secrets engine")
    plaintext = b"mysecretplaintext"
    transit_mount = os.getenv("VAULT_TRANSIT_SECRETS_MOUNT")
    transit_engine_name = os.getenv("VAULT_TRANSIT_SECRETS_KEY_NAME")
    encrypt_data_response = client.secrets.transit.encrypt_data(
        mount_point=transit_mount,
        name=transit_engine_name,
        plaintext=base64.b64encode(plaintext)
    )
    cipher_text = encrypt_data_response.get("data").get("ciphertext")
    print(f"Plain text is: {plaintext}")
    print(f"Cipher text is: {cipher_text}")

    print("Decrypting using transit secrets engine")
    decrypt_data_response = client.secrets.transit.decrypt_data(
        mount_point=transit_mount,
        name=transit_engine_name,
        ciphertext=cipher_text
    )
    decrypted_text = base64.b64decode(decrypt_data_response.get("data").get("plaintext"))
    print(f"Decrypted cipher text is: {decrypted_text}")


def read_from_secrets_file():
    secret_file_path = os.environ["VAULT_SECRET_FILE"]
    print(f"Reading from {secret_file_path}...")
    # the location of secret
    f = open(secret_file_path, "r")

    # put the json object into a python dictionary
    secret_json = json.loads(f.read())
    secrets = secret_json.get("data").get("data")

    # print off your API Key
    print("Secret: ", secrets)
