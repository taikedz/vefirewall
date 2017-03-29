
# ------ Application

function initialize_table {
	local TABLE="$1"; shift
	local CHAIN="$1"; shift

	iptables -t "$TABLE" -P "$CHAIN" ACCEPT
	iptables -t "$TABLE" -F "$CHAIN"
}

function apply_policies {
	local CHAINS="$1"; shift

	# for each chain, get the corresponding rules
	# rules exisiting for chains not specified in Policy section are not applied
	# [table/]CHAIN POLICY
	# [[table/]CHAIN] PORT[/TRANS] [SOURCE/DEST]
	
	while read CHAINLINE; do
		local t_TABLE="${CHAINLINE%/*}"
		CHAINLINE="${CHAINLINE#$t_TABLE/}"
		local t_POLICY="${CHAINLINE#* }"
		local t_CHAIN="${CHAINLINE% $t_POLICY}"
	done < <(echo "$CHAINS")
	unset CHAINLINE
}
