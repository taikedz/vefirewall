# ----- File manip

function read_rules {
	local TFILE="$1"; shift

	local rulesidx=$(egrep -n '^%Rules' -m 1 "$TFILE"|cut -d':' -f1)

	if [[ -z "$rulesidx" ]]; then
		faile "No rule section in $TFILE"
	fi

	local flen=$(wc -l "$TFILE"|cut -d' ' -f1)
	echo "$(sed "$rulesidx,$flen p" -n "$TFILE" | grep -v -P '^(\s*#.*|\s*)$')"
}

function read_policies {
	local TFILE="$1"; shift

	local policyidx=$(egrep -n '^%Policy' -m 1 "$TFILE"|cut -d':' -f1)
	local rulesidx=$(egrep -n '^%Rules' -m 1 "$TFILE"|cut -d':' -f1)

	if [[ -z "$policyidx" ]]; then
		faile "No policy section in $TFILE"
	fi

	if [[ -z "$rulesidx" ]]; then
		faile "No rule section in $TFILE"
	fi

	echo "$(sed "$policyidx,$((rulesidx-1)) p" -n "$TFILE" | grep -v -P '^(\s*#.*|\s*)$')"
}
