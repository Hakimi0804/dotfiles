function waitfor
    test -z "$argv"
    and return 1

    while not test -e $argv
        # Wait for the file
    end
end
