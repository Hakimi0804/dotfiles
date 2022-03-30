function dedup -d "Trim duplicate lines from a text file / stdin"
    isatty stdin # Not piped
    and set -l mode file
    or set -l mode stdin # Something is on stdin

    argparse 'v/verbose' 'w/write' 'h/help' -- $argv
    set -q _flag_verbose
    and set -lx verbose_out /dev/stdout
    or set -lx verbose_out /dev/null

    set -q _flag_write
    and set -lx write_file true
    or set -lx write_file false
    echo "_flag_write: $write_file" >$verbose_out

    set -q _flag_help
    and echo (set_color blue)"Trim duplicate lines from a text file/stdin."
    and echo (set_color blue)""
    and echo (set_color blue)"Flags:"
    and echo (set_color brblue)"    -h, --help    - Show this help message"
    and echo (set_color brblue)"    -v, --verbose - Show duplicate lines"
    and echo (set_color brblue)"    -w, --write   - Write to file instead of stdout. This option is useless when piping from stdin."
    and set_color normal
    and return 0

    set -g __dedup_new_content

    function __dedup
        echo "__dedup: Called" >$verbose_out
        # set -l stdin_content (cat -)
        set -l stdin_content
        cat - | while read std; set -a stdin_content $std; end
        set -l tmp_content
        set skip false
        for cont in $stdin_content
            for tmp_cont in $tmp_content
                if test "$cont" = "$tmp_cont"
                    set skip true
                    echo " -> Duplicate: $cont" >$verbose_out
                    break
                end
            end

            if test "$skip" = true
                set skip false
                continue
            end

            echo " -> unique: $cont" >$verbose_out
            set -a tmp_content $cont
        end
        set __dedup_new_content $tmp_content
    end

    function __dedup_file
        echo "__dedup_file: Called" >$verbose_out
        test -f $argv[1]
        or return 1

        echo "__dedup_file: File passed exists" >$verbose_out
        __dedup <$argv[1]
    end

    if isatty stdin # Not piped, we require a file to be passed
        set -q argv[1]
        or echo (set_color brred)"Give me a file to dedup!"(set_color normal) && return 1

        __dedup_file $argv[1]
        or echo (set_color brred)"File $argv[1] does not exist."(set_color normal) && return 1

        if test "$write_file" = true
            echo "main: Creating tmpfile" >$verbose_out
            set -l tmpfile $argv[1]-(shuf -i 10000-900000 -n1)


            echo "main: Writing to file" >$verbose_out
            # if SOMEHOW a file with that name exist, regenerate, don't risk it
            while test -f $tmpfile
                echo (set_color yellow)"Cannot create tmpfile: a file with the same name exists, regenerating"(set_color normal)
                set tmpfile $argv[1]-(shuf -i 10000-900000 -n1)
            end

            for text in $__dedup_new_content
                echo $text >>$tmpfile
            end
            echo "main: Moving file" >$verbose_out
            mv $tmpfile $argv[1]
        else
            for text in $__dedup_new_content
                echo $text
            end
        end
    else
        echo "main: Reading stdin" >$verbose_out
        # set -l captured_stdin "$(cat /dev/stdin)"
        # cat - | read captured_stdin
        set -l captured_stdin
        cat - | while read capt; set -a captured_stdin $capt; end
        printf '%s\n' $captured_stdin | __dedup
        for text in $__dedup_new_content
            echo $text
        end
    end

    # Sanitize env
    functions -e __dedup_file
    functions -e __dedup_stdin
    set -ge __dedup_new_content
end
