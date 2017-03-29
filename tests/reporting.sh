function rep_pass { echo "[32;1m$*[0m" ; }
function rep_fail { echo "[31;1m$*[0m" ; }
function rep_stat { echo "[33;1m$*[0m" ; }


function testmatch {
	local expected="$1" ; shift
	local message="$1" ; shift

	read
	if [[ "$REPLY" = "$expected" ]]; then
		rep_pass "PASS $message"
	else
		rep_fail "FAIL $message"
		rep_stat "\\___ Got [$REPLY] instead of [$expected]"
	fi
}

function testnomatch {
	local expected="$1" ; shift
	local message="$1" ; shift

	read
	if [[ "$REPLY" != "$expected" ]]; then
		rep_pass "PASS $message"
	else
		rep_fail "FAIL $message"
		rep_stat "\\___ Should not have gotten [$REPLY]"
	fi
}
