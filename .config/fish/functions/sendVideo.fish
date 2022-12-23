function sendVideo
    if test (count $argv) -lt 2
        return 1
    end

    set -l chat_id $argv[1]
    set -l file $argv[2]

    if not test -f "$file"
        echo "File does not exist"
        return 1
    end

    set -l resolution (ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 $file | string split x)
    # resolution[1] = width
    # resolution[2] = height

    if test -z "$API"
        source ~/.token.fish
        source ~/github-repo/tgbot-fish/util.fish
    end

    curl --verbose $API/sendVideo -F chat_id=$chat_id -F video=@$file -F width=$resolution[1] -F height=$resolution[2]
end
