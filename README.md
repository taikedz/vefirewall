# Very Easy Firewall v2

A very basic firewalling script that allows you to manage sets of rule files and apply them as needed.

**Do NOT use vefirewall in conjunction with other firewall management tools.**

Features:

* firewall-set rules are freshly applied at startup
* configure the firewall with simple lists of ports
* add raw rules too!
* actively seeks to maintain and allow SSH connection - no more accidental drops when configuring remote servers!

## Install

Installing is very simple:

	git clone https://github.com/taikedz/vefirewall
	cd vefirewall

	git checkout v2.3

	sudo ./install
	sudo vef apply basic
	sudo vef enable

And you're done.

To customize your rules, you could then also run

	sudo vef edit input

	# ---- Add the ports you need in your editing session ----

	sudo vef save myrules
	sudo vef apply

The editor used is `nano`, if no `$EDITOR` environment variable is set.

## Usage

Make vef apply rules at system start or not (you still need to apply a rule set when enabling, or apply `open-unsafe` when disabling):

	vef { enable | disable }

See vef status:

	vef status

List available rule sets:

	vef list

Load a named set:

	vef load SETNAME

Edit the rule file for the currently loaded set:

	vef edit { input | output | forward | rawpre | rawpost }

Save the active set as a named set:

	vef save SETNAME

Apply the current set as-is, or load a previously saved set (will squash any unsaved modifications!):

	vef apply [SETNAME]


## Sets

The main thing that makes vef so easy is that you can define and save firewall rule sets.

A set is a folder consisting of at least two files, "input" and "output" (and optionally accompanied by "forward", "rawpre" and "rawpost" files too)

Each "input" and "output" file can list any number of port specifications, and allow empty lines and comment lines. Each also specify the policy for the flow direction. Each line is a list of ports to open up. You can write bunches of ports on a single line, or each on their own, one-by-one, it's all the same.

For example, an input file could look like this:

	#%POLICY=DROP

	# Normal HTTP traffic on any interface
	80 443

	# Accept alt web on some internal interface eth2 only
	%eth2 8080

	# DNS packets
	53u

Note the opening of port 8080, which is only done for traffic coming in on interface `eth2`.

Note also the DNS port, which expects UDP traffic, denoted by a "u" attached to the end. It is also possible to specify both TCP and UDP on a port:

	53ut

Another file, "forward" is available to specify the policy for the FORWARD chain. typically, it will only have this content:

	#%POLICY=ACCEPT

Two other files are available are "rawpre" and "rawpost". These allow you to apply rules before, and after, the input and output files are processed. These files simply contain raw arguments to iptables. For example, you may have this in your rawpre file:

	-t nat PREROUTING -p tcp -i eth1 --dport 8080 -j DNAT --to-destination 192.168.56.5:80

to perform some port forwarding from the host's port 8080 to some internal server on port 80.

## Pre-configured sets

VEFirewall comes with a few sets pre-configured:

* `basic` which should satisfy a general use-case, locking down incoming ports except DNS query results.
* `lxc` which sets up the correct forwarding parameters for exposing containers; examples of exposure code are suppliedin the raw files
* `lockdown` which closes everything except the active SSH port
* `open-unsafe` which simply opens up the firewall completely
