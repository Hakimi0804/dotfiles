function sendFile
set -l chat_id $argv[1]
set -l file $argv[2]
source ~/.token.fish
curl $API/sendDocument -F chat_id=$chat_id -F document=@$file
end
