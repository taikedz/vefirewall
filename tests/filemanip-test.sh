. src/filemanip.sh

tfile="config-sets/ssh.rules"

echo ------
read_policies "$tfile"

echo ======
read_rules "$tfile"
