function mem
    while true
        set -l MemAvail (grep MemAvail /proc/meminfo | cut -d: -f2 | tr -d '[:space:]' | string replace -r 'kB$' '')
        echo -n (math $MemAvail / 1024 / 1024) \r
        sleep .03
    end
end
