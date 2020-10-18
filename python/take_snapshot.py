import boto3
import requests
import datetime

from requests_aws4auth import AWS4Auth

credentials = boto3.Session().get_credentials()


class ESHandler:

    def __init__(self):
        self.region = 'ap-south-1'
        self.service = 'es'
        self.host = "<es-host>"

    def get_awsauth(self):
        return AWS4Auth(
            credentials.access_key,
            credentials.secret_key,
            self.region,
            self.service,
            session_token=credentials.token
    )

    def register_repo(self):
        repo_name = "es-snapshot"
        s3_bucket_name = "elastic-kibana-lab-es-snapshot-bucket"

        path = '_snapshot/' + repo_name + 'my-snapshot-repo''/snapshot_' + datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        url = self.host + path

        payload = {
            "type": "s3",
            "settings": {
                "bucket": s3_bucket_name,
                "region": self.region,
                "role_arn": "<role-arn>"
            }
        }

        headers = {"Content-Type": "application/json"}

        r = requests.put(url, auth=self.get_awsauth(), json=payload, headers=headers)

        print(r.status_code)
        print(r.text)


