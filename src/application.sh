
# ------ Application

function initialize_chain {
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
		: # TODO
	done < <(echo "$CHAINS")
	unset CHAINLINE
}

function policy_parts {
	POLICYDEF="$1"; shift
	PART="$1"; shift

	local t_TABLE="${POLICYDEF%/*}"
	POLICYDEF="${POLICYDEF#$t_TABLE/}"
	local t_POLICY="${POLICYDEF#* }"
	local t_CHAIN="${POLICYDEF% $t_POLICY}"

	# If not set, use default
	: "${t_TABLE=filter}"

	case "$PART" in
		table)
			echo "$t_TABLE"
			;;
		chain)
			echo "$t_CHAIN"
			;;
		policy)
			echo "$t_POLICY"
			;;
		*)
			echo "$t_TABLE|$t_CHAIN|$t_POLICY"
			;;
	esac
}

function fw_applypolicy {
	local dTABLE="$1"; shift
	local dCHAIN="$1"; shift
	local dPOLICY="$1"; shift

	iptables -t "$dTABLE" -P "$dCHAIN" "$dPOLICY"
}
