function clearTmp --description 'Clean TMPDIR'
    set -q TMPDIR
    and rm -rf $TMPDIR/*
    or return 1
end
