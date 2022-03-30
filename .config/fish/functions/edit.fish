function edit
if not set -q EDITOR; or test -z "$EDITOR"
echo "\$EDITOR not set, defaulting to nano"
nano $argv
else
$EDITOR $argv
end
end
