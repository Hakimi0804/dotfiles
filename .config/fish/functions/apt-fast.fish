function apt-fast --wraps=apt-get
    command apt-fast $argv
    # This function is only to get apt-get completions inherited
end
