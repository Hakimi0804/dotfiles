function ins-refresh --wraps='dnf install --refresh' --description 'Install packages with --refresh'
    dnf_func_pre_common
    dnf install --refresh $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
