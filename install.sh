#!/bin/bash

if [[ "$UID" != 0 ]]; then
	echo "You must be root to run this script"
	exit 1
fi

cd "$(dirname "$0")"

# --- The actual service

cp bin/vef /usr/local/bin/vef
chmod 755 /usr/local/bin/vef

umask 022

mkdir /var/lib/vefirewall -p
cp {pkg,}/var/lib/vefirewall/vef-restore
cp {pkg,}/etc/systemd/system/vef.service

systemctl daemon-reload

# --- User-oriented data

# Don't squash sets on update
if [[ ! -d /etc/vefirewall/sets ]] || [[ "$*" =~ --restore-sets ]]; then
	umask 177
	mkdir -p /etc/vefirewall/sets
	cp default-sets/* /etc/vefirewall/sets/ -r
fi

# --- Final help

cat <<'EOF'
Very Easy Firewall is now installed!

Enable auto-restore of rules on startup:

	sudo vef enable

See `vef --help` for more information.

EOF
