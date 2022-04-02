function sendFile
    #argparse 'f/file=' -- $argv
    #or return 1

    set -l chat_id $argv[1]
    set -l file $argv[2]
    source ~/.token.fish

    echo $_flag_file
    set -q $_flag_file
    #and curl $API/sendDocument -F chat_id=$chat_id -F document=@$_flag_file
    curl $API/sendDocument -F chat_id=$chat_id -F document=@$file # Actually id but anyway
end
