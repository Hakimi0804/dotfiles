function dnf_func_pre_common
rm -f /var/cache/dnf/fastestmirror.cache
test $debug
and echo "Removed dnf fastestmirror cache"
end
