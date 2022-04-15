function cmkdir
    test (count $argv) -eq 0
    and return 1

    mkdir $argv
    or return

    test (count $argv) -gt 1
    and echo "Warning: Cannot enter multiple directory" \
        && return

    cd $argv
end
