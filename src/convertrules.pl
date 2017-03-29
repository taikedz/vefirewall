# [[table/]CHAIN] PORT[/TRANS] [SOURCE/DEST]

sub feedback {
	print(@_);
}

while(<>)
{
	my $table = "filter";
	my $chain = "INPUT";
	my $port;
	my $transport="tcp";
	my $source="0.0.0.0";
	my $destination="0.0.0.0";

	if ( "$_" =~ m/(.+? +)?([0-9]+.+?)( +.+)?/ )
	{
		feedback("Processing $_ > ");
		my $tchain = "$1";
		my $ptrans = "$2";
		my $sdest  = "$3";

		if ( "$tchain" =~ m@((filter|nat|mangle|raw|security)/)?([a-zA-Z0-9-]+)@ )
		{
			if ( "$2" != "" )
			{
				$table = "$2";
			}

			$chain = "$3";
		}

		if ( "$ptrans" =~ m@([0-9]+(/(tcp|udp))?)@ )
		{
			$port = "$1";
			if ( "$3" != "" )
				{$transport = "$3";}
		}

		if ( "$sdest" =~ m@($ip)/($ip)@ )
		{
			$source = "$1";
			$destination = "$2";
		}

		# -m state --state NEW -p udp --dport $FPORT -j ACCEPT
		print("-t $table -A $chain -m state NEW -p $transport --dport $port -s $source -d $destination -j ACCEPT\n")
	} else
	{
		feedback("Raw data $_ > ");
		print("$_");
	}
}
