function rr
    set -l def_rate 120.00001
    set -l force_rate 1

    switch $argv[1]
        case reset
            bash /sdcard/shizuku/rish -c "settings put system peak_refresh_rate $def_rate"
        case force
            bash /sdcard/shizuku/rish -c "settings put system peak_refresh_rate $force_rate"
        case '*'
            set_color brred
            echo "Invalid operation" >&2
    end
end
