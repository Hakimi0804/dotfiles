function metacache --description 'Create metadata cache (dnf makecache)'
    dnf_func_pre_common
    dnf makecache
    dnf_func_post_common
end
# dnf_func_pre_common
# dnf_func_post_common
