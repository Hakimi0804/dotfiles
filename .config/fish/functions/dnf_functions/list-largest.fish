function list-largest --description 'List largest installed packages'
    dnf_func_pre_common
    rpm -qa --queryformat '%10{size} - %-25{name} \t %{version}\n' | sort -rn | head -n $argv[1] 2>/dev/null
    or rpm -qa --queryformat '%10{size} - %-25{name} \t %{version}\n' | sort -rn # In case $argv[1] wasn't integer
    dnf_func_post_common

end
# dnf_func_pre_common
# dnf_func_post_common
