function musicdl
    argparse f/format= p/max-parallel-downloads= F/file= h/help -- $argv
    or return

    # Help message
    if set -q _flag_help
        __musicdl_help
        return 0
    end

    # Files handling
    set -l links
    if set -q _flag_file
        set links (cat $_flag_file | string replace -ar '#.*' '') $argv
    else
        set links $argv
    end

    # Only allow certain format
    set -l supported_fmt mp3 flac
    set -l format flac
    if set -q _flag_format
        if not contains $_flag_format $supported_fmt
            set_color brred
            echo "Format is not supported" >&2
            set_color normal
            return 1
        else
            set format $_flag_format
        end
    end

    # Make sure max parallel downloads is integer,
    # not exceeding 20
    set -l max_p_dl 5
    if set -q _flag_p
        if not string match -qr '^[0-9]+$' $_flag_p
            set_color brred
            echo "Max parallel downloads is not an integer" >&2
            set_color normal
            return 1
        else
            # Make sure it's not over the limit
            if test "$_flag_p" -gt 20
                set_color brred
                echo "max parallel dl: Max value is 20"
                set_color normal
                return 1
            else if test "$_flag_p" -lt 1
                set_color brred
                echo "max parallel dl: Min value is below 1"
                set_color normal
                return 1
            else
                set max_p_dl $_flag_p
            end
        end
    end

    if test (count $links) -eq 0
        set_color brred
        echo "Give me at least one link to download"
        set_color normal
        return 100
    end

    # Make sure we're in music directory
    set -l dir_changed false
    if not test "$PWD" = /storage/emulated/0/Music
        and not test "$(readlink -f $PWD)" = /storage/emulated/0/Music
        echo "Changing directory to /storage/emulated/0/Music"
        cd /storage/emulated/0/Music
        or return 255
        set dir_changed true
    end

    for link in $links
        youtube-dl -x --audio-format=$format --audio-quality=1 $link &

        if test (jobs | count) -ge $max_p_dl
            while test (jobs | count) -ge $max_p_dl
                : # Wait
            end
        end
    end
    wait

    # Go back to previous dir if needed
    if test "$dir_changed" = true
        prevd
    end
end

function __musicdl_help
    echo "Usage: musicdl <link1> [link2,3,4...]"
    echo
    echo "\
Flags:
    -f, --format=<flac,mp3> - Alter format
    -p, --max-parallel-downloads=<int> - Change parallel download limit (max: 20, min: 1)
    -F, --file=<filename> - Get links from a file
"
end
