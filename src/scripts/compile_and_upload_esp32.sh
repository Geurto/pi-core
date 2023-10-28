#!/bin/bash

if ! ./find_usb.sh; then
    echo "Could not find USB device"
    exit 1
fi

arduino-cli compile \
            -b esp32:esp32:esp32 \
            -o /home/pi/build/piranha.bin \
            /home/pi/src/piranha/piranha.ino