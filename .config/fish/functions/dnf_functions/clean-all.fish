function clean-all --wraps='dnf clean all' --description 'Clean all (dnf clean all)'
    dnf_func_pre_common
    dnf clean all $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
