# 1. Pre-populate /etc/skel with official Dux Shell + Niri default configs at build time
mkdir -p /etc/skel/.config /etc/skel/.local/state
HOME=/etc/skel XDG_CONFIG_HOME=/etc/skel/.config XDG_STATE_HOME=/etc/skel/.local/state \
    /usr/bin/dms setup headless --compositor niri --terminal ghostty || true

# 2. Create the greeter cache directory with correct permissions
mkdir -p /var/cache/dms-greeter
chown -R greeter:greeter /var/cache/dms-greeter || true