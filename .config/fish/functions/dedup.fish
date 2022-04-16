function dedup
    set -l deduped
    for arg in $argv
        set -l skip false

        for item in $deduped
            if test "$arg" = "$item"
                set skip true

                set -q debug
                and begin
                    set_color yellow
                    echo " > Duplicate: $arg" >&2
                    set_color normal
                end

                break
            end
        end

        if test "$skip" = true
            continue
        end

        set -a deduped $arg
    end

    echo $deduped
end
