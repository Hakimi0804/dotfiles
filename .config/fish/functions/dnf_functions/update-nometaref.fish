function update-nometaref --wraps='dnf upgrade -C' --description 'Update packages without refreshing repo meta'
    dnf_func_pre_common
    dnf upgrade -C $argv
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
