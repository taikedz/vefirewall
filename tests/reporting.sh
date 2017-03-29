function testmatch {
	local expected="$1" ; shift
	local message="$1" ; shift

	read
	if [[ "$REPLY" = "$expected" ]]; then
		echo "PASS $message"
	else
		echo "FAIL $message"
		echo "\\___ Got [$REPLY] instead of [$expected]"
	fi
}

function testnomatch {
	local expected="$1" ; shift
	local message="$1" ; shift

	read
	if [[ "$REPLY" != "$expected" ]]; then
		echo "PASS $message"
	else
		echo "FAIL $message"
		echo "\\___ Got [$REPLY] which is [$expected]"
	fi
}
