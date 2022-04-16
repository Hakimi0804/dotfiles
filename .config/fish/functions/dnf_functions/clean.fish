function clean --wraps='dnf clean packages' --description 'Clean packages (dnf clean packages)'
    dnf_func_pre_common
    dnf clean packages $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
