function ins --wraps='dnf install' --description 'Install packages (dnf install)'
    dnf_func_pre_common
    dnf install $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
