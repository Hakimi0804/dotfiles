function termux_change_font
    if not command -sq termux-fix-shebang # Randomly picked termux script
        # Not termux, erase and exit
        functions -e (status function)
        return 1
    end

    if not test -d $HOME/.termux
        mkdir -p $HOME/.termux
    end

    if test (count $argv) -ne 1
        echo "Expected one arg, got $(count $argv) instead" >&2
        return 1
    end

    if not test -f $argv
        echo "File '$argv' does not exist" >&2
        return 1
    end

    # Preserve old font (if any)
    set -l font_location $HOME/.termux/font.ttf
    set -l old_font_preserved_name (dirname $font_location)/font.ttf.pres-(date +%s-%N)
    if test -f "$font_location"
        echo "Warning: preserving old font as '$old_font_preserved_name'" >&2
        mv $font_location $old_font_preserved_name
    end

    # Copy the font
    cp -f $argv $font_location
    echo "Copied $argv"

    termux-reload-settings &
    while contains -- $last_pid (jobs -p)
        echo -n Applying changes \| \r
        sleep .03
        echo -n Applying changes / \r
        sleep .03
        echo -n Applying changes - \r
        sleep .03
        echo -n Applying changes \\ \r
        sleep .03
    end
    echo Applying changes ✓
end
