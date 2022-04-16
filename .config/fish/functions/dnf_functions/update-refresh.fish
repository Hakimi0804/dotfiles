function update-refresh --wraps='dnf upgrade --refresh' --description 'Update packages (dnf upgrade --refresh)'
    dnf_func_pre_common
    dnf upgrade --refresh
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
