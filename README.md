# Very Easy Firewall v2

A very basic firewalling script that allows you to manage sets of rule files
and apply them as needed.

**Do NOT use vefirewall in conjunction with other firewall management tools.**

--- Installing ---

Installing is very simple:

	git clone https://github.com/taikedz/vefirewall
	cd vefirewall
	git check v2.0
	sudo ./install

And you're done.

--- Usage ---

	vef list
	vef apply SETNAME

SETNAME is the name of a set directory in /etc/vefirewall/sets, or an explicit
path to a set directory.

--- Sets ---

You can define sets in /etc/vefirewall/sets , or save them anywhere you wish.

A set is a folder consisting of at least two files, "input" and "output"

Each "input" and "output" file can list any number of port specifications,
and allow empty lines and comment lines. Each also spciy the policy for
the flow direction -- for example, an input file could look like this:

	#%POLICY=DROP

	# Normal HTTP traffic on any interface
	80 443

	# Accept alt web on some internal interface eth2 only
	%eth2 8080

	# Minetest
	30000u

Note the Minetest port, which expects UDP traffic, denoted by a "u". The default
assignment is to TCP, but ports can also be specified for both:

	5000ut # opens port 5000 for both UDP and TCP traffic

Another file, "forward" is available to specify the policy for the FORWARD chain.

Two other files are available are "rawpre" and "rawpost". These allow you to apply
rules before, and after, the input and output files are processed. These files simply
contain raw arguments to iptables. For example, you may have this in your rawpre file:

	-t nat PREROUTING -p tcp -i eth1 --dport 8080 -j DNAT --to-destination 192.168.56.5:80

to perform some port forwarding from the host's port 8080 to some internal server on port 80.

--- SSH ---

By default, the port of the SSH daemon is detected and added to the
allowed incoming ports. To cancel this behaviour, set the NOSSH variable:

	NOSSH=true vef apply default

