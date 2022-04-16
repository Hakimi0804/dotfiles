function list --wraps='dnf list --installed' --description 'List installed packages'
    dnf_func_pre_common
    dnf list --installed $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
