function ins-nometaref --wraps='dnf install -C' --description 'Install packages without repo meta refresh'
    dnf_func_pre_common
    dnf install -C $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
