function searchq --wraps='dnf repoquery' --description 'Search packages using dnf repoquery'
    dnf_func_pre_common
    dnf repoquery $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
