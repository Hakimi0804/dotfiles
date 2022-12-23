function run
    set -q argv[1]
    and set filename $argv[1]

    set -q filename
    or set filename main.cpp

    set_color brblack
    echo Compiling...
    set_color normal
    clang++ $filename -o main
    or return
    set_color brblack
    echo "## Compilation succeeded ##"
    set_color normal
    ./main
end
