function fixperm
    test (count $argv) -gt 0
    and sudo chown -R (whoami) $argv
    or return 1
end
