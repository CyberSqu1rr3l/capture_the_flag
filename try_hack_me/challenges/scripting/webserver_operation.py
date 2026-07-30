#!/usr/bin/python3

import requests
import sys
import socket
import time
import re

def obtain_first_port_number(ip_address):
    """Get the first port number from the website by performing a request."""
	url = str("http://" + ip_address + ":3010")

	headers = {
	    "Accept": "text/html,application/xhtml+xml,image/webp,*/*;q=0.8",
	    "Accept-Language": "en-US,en;q=0.5",
	    "Accept-Encoding": "gzip, deflate",
	    "Connection": "keep-alive",
	    "Upgrade-Insecure-Requests": "1",
	}

	response = requests.get(url, headers=headers)
	match = re.search(r'id="onPort">(\d+)<', response.text)
	if match:
	    port = int(match.group(1))
	    return port


def compute_math_challenge(operation, old_num, new_num):
    if operation == 'add':
        return old_num + new_num
    elif operation == 'minus':
        return old_num - new_num
    elif operation == 'divide':
        return old_num / new_num
    elif operation == 'multiply':
        return old_num * new_num
    else:
        print(f"[INFO] The operation {operation} is unknown, skipping.")
        return None


def assign_received_data(data):
    """This method receives a HTTP response and then assigns the information
       into usable operation, number and port variables for the challenge.

    :param data: The raw data as it was sent by the server for computation.
    """
    # Split data with a mutli delimiter and filter for null strings
    dataArr = re.split(' |\*|\n', data)
    dataArr = list(filter(None, dataArr))

    # Assign the last three values of the data to the operation, number and port
    operation = dataArr[-3]
    new_num = float(dataArr[-2])
    next_port = int(dataArr[-1])

    return operation, new_num, next_port


def main():
    if len(sys.argv) > 1:
        TARGET_MACHINE_IP_ADDRESS = sys.argv[1]
    else:
        sys.exit("[USAGE] ./webserver_operation.py [TARGET_MACHINE_IP_ADDRESS]")

    # port = obtain_first_port_number(TARGET_MACHINE_IP_ADDRESS)
    port = 1337
    number = 0
    first_attempt = True

    while port != 9765:
        if first_attempt:
            url = f"http://{TARGET_MACHINE_IP_ADDRESS}:{port}/"
            print(f"[NOTE] Connecting to the web server on {url}")
        try:
            response = requests.get(url, timeout=2)
            data = response.text.strip()

            print(f"[DATA] The data is (operation, number, next port) = {data}")

            if data == "STOP":
                break

            operation, new_num, next_port = assign_received_data(data)

            number = compute_math_challenge(operation, number, new_num)

            print(f"[DONE] The current number is {number}, moving to the next port {next_port}.\n")

            port = next_port
            first_attempt = True

        except requests.RequestException:
            if first_attempt:
                print(f"[HOLD] The port {port} is currently unavailable, retrying to connect.")
                first_attempt = False
            time.sleep(1)

    print(f"[PASS] The final value of the number is {round(number,2)}.")


if __name__ == '__main__':
    main()

