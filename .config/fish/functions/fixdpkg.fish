function fixdpkg
    for arg in $argv
        set -l prefix sudo

        # Extract the .deb package
        echo "Processing $arg"

        # Unpack with ar
        $prefix ar -x $arg

        # Unpack with xz
        $prefix unxz data.tar.xz

        # Unpack with tar
        set -l tmpdir tartmp
        $prefix mkdir $tmpdir
        $prefix tar -xf data.tar -C $tmpdir

        # Create PREFIX directory
        $prefix mkdir -p $tmpdir$PREFIX

        # Move files
        $prefix mv $tmpdir/* $tmpdir$PREFIX 2>/dev/null
        $prefix mv $tmpdir$PREFIX/usr/* $tmpdir$PREFIX
        $prefix rm -rf $tmpdir$PREFIX/usr

        # Repack with tar
        $prefix tar -cf newdata.tar -C $tmpdir .

        # xz
        $prefix xz newdata.tar

        # ar
        $prefix mv newdata.tar.xz data.tar.xz
        $prefix ar -f newpackage.deb -q data.tar.xz debian-binary

        # Cleanup
        $prefix rm -rf $tmpdir debian-binary data.tar* control.tar.xz

        # Rename
        test -d oldpkgs
        or $prefix mkdir oldpkgs

        $prefix cp $arg oldpkgs
        $prefix mv newpackage.deb $arg

        test "$prefix" = sudo
        and sudo chown -R (whoami) .
    end
end
