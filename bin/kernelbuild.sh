#!/bin/sh
export KCFLAGS="-Ofast -march=znver2 -pipe"
export KPPCFLAGS="-Ofast -march=znver2 -pipe"
make modules_prepare
make -j24 && make modules_install && make install
genkernel --install --kernel-config=/usr/src/linux/.config initramfs
emerge @module-rebuild
grub-mkconfig -o /boot/efi/grub/grub.cfg

