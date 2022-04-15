function ftouch
    test (count $argv) -eq 0
    and return 1

    for file in $argv
        if string match -qr '.fish$'
            test -f $file
            or echo "#!/bin/fish" >$file
        else
            test -f $file.fish
            or echo "#!/bin/fish" >$file.fish
        end
    end
end
