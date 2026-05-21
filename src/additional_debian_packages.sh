#!/usr/bin/env bash

sed -i 's/Components: main/Components: main contrib non-free-firmware non-free/g' /etc/apt/sources.list.d/debian.sources
apt-get update -y &> /dev/null
apt-get install -y $ADDITIONAL_PACKAGES &> /dev/null