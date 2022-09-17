# This file is meant to be sourced (or place in fish_function_path)

function refresh-rate::updateCurrentApp
    /system/bin/dumpsys activity activities |
        grep mFocusedWindow |
        tr -d '[:space:]' |
        sed 's/mFocusedWindow=Window{.........//' |
        cut -d/ -f1
end

function refresh-rate::setRefreshRate
    refresh-rate::log "debug: $(status function) called"
    #switch $argv[1]
    #    case force
            refresh-rate::log "debug: $(status function): force called"
            rish -c "settings put system peak_refresh_rate 1"
            refresh-rate::log "Refresh rate forced"
    #    case reset
            refresh-rate::log "debug: $(status function): reset called"
            rish -c "settings put system peak_refresh_rate 120.00001"
            refresh-rate::log "Refresh rate reset"
    #end
end

function refresh-rate::log
    echo $argv
    echo $argv >>$HOME/refresh-rate.log
end

function refresh-rate::getShellPermStatus
    if rish -c true 2>/dev/null
        return 0
    else
        return 1
    end
end

function refresh-rate
    if test -f $HOME/refresh-rate.log
        rm -f $HOME/refresh-rate.log
        refresh-rate::log "Log purged"
    end

    if not test -f $HOME/refresh-rate.conf
        refresh-rate::log "Cannot find $HOME/refresh-rate.conf"
        return 1
    end

    set -l FORCE_PKGS (cat $HOME/refresh-rate.conf)

    while not refresh-rate::getShellPermStatus
        test -z "$wait_printed" && refresh-rate::log "Waiting for shizuku"
        set -l wait_printed true
    end

    refresh-rate::log "Shizuku started"


    set -g refresh_rate_forced false
    set -g current_app (refresh-rate::updateCurrentApp)
    while true
        if test "$(refresh-rate::updateCurrentApp)" != "$current_app"
            set current_app (refresh-rate::updateCurrentApp)
            refresh-rate::log "App changed, current app: $current_app"
        end

        if contains $current_app $FORCE_PKGS && test "$refresh_rate_forced" = false
            refresh-rate::log "App '$current_app' found in force list, setting refresh rate to 120hz"
            # refresh-rate::setRefreshRate force
            # rish -c "settings put system peak_refresh_rate 1"
            rr force
            set refresh_rate_forced true
        else if not contains $current_app $FORCE_PKGS && test "$refresh_rate_forced" = true
            refresh-rate::log "App changed, resetting refresh rate"
            # refresh-rate::setRefreshRate reset
            # rish -c "settings put system peak_refresh_rate 120.0001"
            rr reset
            set refresh_rate_forced false
        end
    end
end
