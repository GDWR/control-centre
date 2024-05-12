#!/usr/bin/env python3
# This script is expected to recieve the json data from `tofu output`
import asyncio
import json
import sys

import httpx
from rich import print

retries = 5
retry_delay_seconds = 10

json_data = sys.stdin.read()
data = json.loads(json_data)

if "urls" not in data:
    print("[yellow]:warning: No urls found, if you was expecting some run[/yellow] [bold]`tofu refresh`[/bold]")
    sys.exit(1)

urls = data["urls"]["value"]
print(f"Testing {len(urls)} URLs")

client = httpx.AsyncClient()

async def _test_url(url: str) -> tuple[bool, str]:
    try:
        http = await client.get(url)

        if http.status_code in range(200, 300):
            return True, f"  :white_check_mark: [bold green]{http.status_code}[/bold green] [bold cyan]{url}[/bold cyan]"
        else:
            return False, f"  :x: [bold red]{http.status_code}[/bold red] [bold cyan]{url}[/bold cyan]"
    except httpx.ConnectError:
        return False, f"  :x: [bold gray]not reachable[/bold gray] [bold cyan]{url}[/bold cyan]"


async def test_url(url: str) -> str:
    """Wraps the _test_url adding retries"""
    for r in range(retries):
        status, message = await _test_url(url)
        if status:
            return message + (f" [yellow](retries: {r})[/yellow]" if r > 1 else '' )

        await asyncio.sleep(retry_delay_seconds)

    return message + " (max retries reached)"

async def main():
    tests = {test_url(url) for url in urls}

    for task in asyncio.as_completed(tests):
        print(await task)

asyncio.run(main())
