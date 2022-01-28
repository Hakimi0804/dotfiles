# shellcheck shell=bash
icefox() {
    echo "killing firefox"
    if [ "$1" = "sigkill" ]; then
        echo "force closing"
        killall /usr/lib64/firefox/firefox -s SIGKILL # (force close)
    else
        killall /usr/lib64/firefox/firefox
    fi
}