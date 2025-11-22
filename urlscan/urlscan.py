#!/usr/bin/env python3
# Started with https://github.com/montysecurity/InfraHunter but only use the
# code for urlscan.io.

from time import sleep

# pylint: disable=W0622
from rich import print
from pathlib import Path
import argparse
import configparser
import hashlib
import json
import requests
import sys


def read_configuration(config_file):
    """Read configuration file."""
    config = configparser.RawConfigParser()
    config.read(config_file)
    if not config.sections():
        print("Can't find configuration file.")
        sys.exit(1)
    return config


def get_one_image(checked_url, image_url, uuid):
    """Get one image from urlscan.io."""
    image_request = requests.get(image_url, timeout=10)
    status_code = image_request.status_code
    if status_code == 200:
        with open(f"images/{uuid}.png", "wb") as f:
            for block in image_request.iter_content(1024):
                if not block:
                    break
                f.write(block)
        with open(f"images/{uuid}.png", "rb") as f:
            data = f.read()
            sha256 = hashlib.sha256(data).hexdigest()
        # If not a blank page
        if sha256 != "8a8a7e22837dbbf5fae83d0a9306297166408cd8c72b3ec88668c4430310568b":
            print(f"RESULT {checked_url}: {image_url} and images/{uuid}.png")
        else:
            Path.unlink(f"images/{uuid}.png")
            print(f"[red]Blank image[/red] for {checked_url}. Image removed.")
    elif status_code == 404:
        sleep(2)
    return status_code


def get_images(uuids):
    """Get images from urlscan.io."""
    for uuid in uuids:
        checked_url = uuids[uuid]
        image_url = f"https://urlscan.io/screenshots/{uuid}.png"
        status_code = 404
        while status_code == 404:
            status_code = get_one_image(checked_url, image_url, uuid)


def urlscan_submission(url, urlscan_key):
    """Submit url to urlscan."""
    scan_type = "public"
    headers = {"API-Key": urlscan_key, "Content-Type": "application/json"}
    data = {"url": url, "visibility": scan_type}
    response = requests.post(
        "https://urlscan.io/api/v1/scan/",
        headers=headers,
        data=json.dumps(data),
        timeout=10,
    )
    if response.status_code == 200:
        print(f"[green]Submitted {url}[/green]")
    elif response.status_code == 429:
        print(
            f"[red]URLSCAN: We somehow exceeded an API limit checking url {url}.[/red]"
        )
        return {}
    else:
        print("[red]URLSCAN: Encountered an unknown API error. Quitting.[/red]")
        sys.exit()
    uuid = response.json()["uuid"]
    return {uuid: url}


def main():
    """Main function."""
    uuids = {}
    parser = argparse.ArgumentParser(description="Get images from URLScan")
    parser.add_argument(
        "urls", metavar="urls", type=str, nargs="+", help="urls to check"
    )

    config = read_configuration("urlscan.conf")
    args = parser.parse_args()

    if not Path("images").is_dir():
        Path("images").mkdir()

    urls = args.urls
    urlscan_apikey = config.get("urlscan", "apikey")

    for url in urls:
        urlscan_result = urlscan_submission(url, urlscan_apikey)
        if urlscan_result != {}:
            uuids.update(urlscan_result)

    get_images(uuids)


if __name__ == "__main__":
    main()
