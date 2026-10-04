#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Install ProtonVPN repository by dynamically resolving the Fedora version
dnf install -y https://repo.protonvpn.com/fedora-$(rpm -E %fedora)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.4-1.noarch.rpm

# Install the client in "offline" mode to avoid systemd failures
export SYSTEMD_OFFLINE=1 && dnf install -y proton-vpn-gnome-desktop

# Cleans up repos and cache to reduce image size and speed up dnf searches
rm -f /etc/yum.repos.d/protonvpn*.repo && dnf clean all
