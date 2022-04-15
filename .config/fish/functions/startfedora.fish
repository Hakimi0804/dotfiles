function startfedora
    set -l sudo (which sudo)
    set -l su (which su)
    set -l chroot (which chroot)
    set -l su_flags  --preserve-environment -c
    #set -l distro_path $pdistro_path/installed-rootfs/fedora

    # Sanity check
    function startfedora::fail
        echo (set_color brred)$argv(set_color normal) >&2
    end

    set -q distro_path
    or startfedora::fail "distro_path variable not set, exiting" && return 1

    test -d "$distro_path"
    or startfedora::fail "distro_path is not a dir/unreadable" && return 1

    set -l partitions sys proc dev apex system vendor

    argparse r/remount -- $argv

    # Mount /sys, /dev, /proc
    if test -z "$(mount | grep $distro_path)"
        for part in $partitions
            sudo mount --bind /$part $distro_path/$part
        end
    end

    if set -q _flag_remount
        echo Remounting...

        for part in $partitions
            sudo umount $distro_path/$part
        end 2>/dev/null

        for part in $partitions
            sudo mount --bind /$part $distro_path/$part
        end 2>/dev/null

        echo Remounted.
    end

    # Setup bin paths
    set -lx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin
    set -lx HOME /root
    set -lx LD_PRELOAD ''
    set -lx TMPDIR /tmp
    test -n "$argv"
    and $su $su_flags chroot $distro_path $argv
    or $su $su_flags chroot $distro_path /bin/fish
    # and $sudo -E chroot $distro_path $argv
    # or $sudo -E chroot $distro_path /bin/fish
end
