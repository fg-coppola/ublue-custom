#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Install build dependencies for the fingerprint shim
dnf install -y gcc glib2-devel pkgconf patchelf fprintd fprintd-pam

# Clone the community shim repository
git clone https://github.com/leopalladium/focaltech-ft9366-arch-shim.git /tmp/ft9366
cd /tmp/ft9366

# Compile the compatibility shim
gcc -shared -fPIC -Wl,--version-script=shim.map -o focaltech-shim.so shim.c $(pkg-config --cflags --libs glib-2.0) -ldl

# Install the proprietary driver and shim to Fedora's lib64 directory
cp libfprint-2.so.2.0.0 /usr/lib64/
cp focaltech-shim.so /usr/lib64/

# Inject the shim as a dependency into the driver using patchelf
patchelf --add-needed focaltech-shim.so /usr/lib64/libfprint-2.so.2.0.0

# Clean up temporary files
rm -rf /tmp/ft9366

# Declaratively enable fingerprint authentication system-wide
# This configures PAM for sudo, polkit, SDDM, and the lockscreen.
# It safely falls back to password if no fingerprint is enrolled.
authselect enable-feature with-fingerprint