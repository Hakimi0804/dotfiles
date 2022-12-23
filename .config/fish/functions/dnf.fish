function dnf --description 'alias dnf=sudo dnf'
    if test "$argv[1]" = download
        #set -a argv --setopt fastestmirror=True
    end

    doas dnf $argv

    if test "$argv[1]" = download
        #doas rm /var/cache/dnf/fastestmirror.cache
    end
end
