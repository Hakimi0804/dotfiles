function tmp --on-variable PWD
if not set -q __tmp_init_complete
functions --copy edit __old_edit
set -g __tmp_init_complete
end

if test "$PWD" = "$HOME/tmp"

function edit
micro test.c
end
function compile
clang test.c -o test
end
function run
clang test.c -o test
./test
end

else
functions -e compile run edit 2>/dev/null
functions --copy __old_edit edit 2>/dev/null
end
end
