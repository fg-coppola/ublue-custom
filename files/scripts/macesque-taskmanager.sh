#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

git clone https://github.com/snpynk/macesque-taskmanager.git /tmp/macesque-taskmanager
cd /tmp/macesque-taskmanager

mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
make -j$(nproc)
make install

rm -rf /tmp/macesque-taskmanager