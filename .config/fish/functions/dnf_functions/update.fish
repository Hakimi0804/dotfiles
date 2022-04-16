function update --wraps='dnf upgrade' --description 'Update packages (dnf upgrade)'
    dnf_func_pre_common
    dnf upgrade
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
