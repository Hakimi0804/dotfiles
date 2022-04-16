function search --wraps='dnf search' --description 'Search packages'
    dnf_func_pre_common
    dnf search $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
