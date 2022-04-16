function bsnload
    for arg in $argv
        set -l arg (string replace -r '.fish$' '' $arg)
        source functions/$arg.fish
    end
end
