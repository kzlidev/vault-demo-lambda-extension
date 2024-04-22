import boto3
import os
import json


def lambda_handler(event, context):
    # the location of secret
    secret_file = os.environ["VAULT_SECRET_FILE"]
    f = open(secret_file, "r")

    # put the json object into a python dictionary
    vault_response = json.loads(f.read())
    secrets = vault_response.get("data").get("data")

    # print off your API Key
    print("Secret: ", secrets)

    return {
        "statusCode": 200,
        "body": secrets
    }
