# shellcheck shell=bash

alias fstab="sudo nano /etc/fstab"
alias reload="source ~/.bashrc"
alias symlink="ln -s"
export SSH_ASKPASS=/usr/bin/ksshaskpass
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
function compileclang() {
    # Path to executables in Clang toolchain
    clang_bin="$HOME/toolchains/proton-clang/bin"

    # export LD_LIBRARY_PATH="$clang_bin/../lib:$clang_bin/../lib64:$LD_LIBRARY_PATH"
    export PATH="$clang_bin:$PATH"
    which clang
    echo "using -j6"
    make_flags=(
        -j6
        ARCH="arm64"
        O="out"
        CC="clang"
        AR="llvm-ar"
        NM="llvm-nm"
        OBJCOPY="llvm-objcopy"
        OBJDUMP="llvm-objdump"
        STRIP="llvm-strip"
        CROSS_COMPILE="aarch64-linux-gnu-"
        CROSS_COMPILE_ARM32="arm-linux-gnueabi-")
    make "${make_flags[@]}" $1_defconfig
    # make "${make_flags[@]}" 2>&1 | tee log.txt
    make "${make_flags[@]}"

}

