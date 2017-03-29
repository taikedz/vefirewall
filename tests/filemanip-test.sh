. src/filemanip.sh
. tests/reporting.sh

tfile="tests/dummyrulefile.txt"

read_policies "$tfile"|md5sum|tee /dev/stderr | testmatch "cea1269d7cd4af58a78e2b540b37c7a4  -" "Policy reading"

read_rules "$tfile"|md5sum|tee /dev/stderr | testmatch "647290e28390b2dca52c05f6806ae718  -" "Rules reading"


