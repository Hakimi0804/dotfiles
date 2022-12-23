function clearTmp --description 'Clean TMPDIR'
    test -n "$TMPDIR"
    and rm -rf $TMPDIR/*
    or return 1
end
