#!/bin/sh
# Build qemu-system-aarch64 with the vresearch machine and VNC on Debian.
set -e

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  build-essential ninja-build pkg-config git \
  python3-venv python3-pip python3-setuptools python3-wheel \
  libglib2.0-dev libpixman-1-dev zlib1g-dev libslirp-dev libfdt-dev

./configure \
  --target-list=aarch64-softmmu \
  --enable-vnc \
  --enable-slirp \
  --disable-docs \
  --disable-werror

make -C build -j"$(nproc)"

echo "built binary: build/qemu-system-aarch64"
