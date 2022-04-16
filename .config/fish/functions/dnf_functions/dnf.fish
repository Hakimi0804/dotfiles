function dnf --description 'alias dnf=dnf'
    dnf_func_pre_common
    sudo dnf $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
