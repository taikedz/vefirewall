. src/application.sh
. tests/reporting.sh

# Test env setup

function iptables {
	echo iptables "$*"
}

# Tests

# Using md5sum because output is multiline
initialize_table nat THROUGHPUT|md5sum | testmatch "939bacda0f27e73a1a68aa14e3a164cb  -" "Table initialization"
