# Building on Debian or Ubuntu

The aarch64-softmmu target with the vresearch machine and the VNC display
server needs only a small set of packages:

```
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  build-essential ninja-build pkg-config git \
  python3-venv python3-pip python3-setuptools python3-wheel \
  libglib2.0-dev libpixman-1-dev zlib1g-dev libslirp-dev libfdt-dev
```

Configure and build:

```
./configure \
  --target-list=aarch64-softmmu \
  --enable-vnc \
  --enable-slirp \
  --disable-docs \
  --disable-werror
make -C build -j"$(nproc)"
```

The result is `build/qemu-system-aarch64`. The configure script creates a
Python virtual environment and installs the vendored Meson wheel from
`python/wheels`, so no matching system Meson is required; `python3-venv`
must be installed so that `ensurepip` is available.

`scripts/build.sh` runs the same steps.

To check that the VNC server comes up, run the binary with a VNC display
on port 5901 (display :1) and no machine:

```
./build/qemu-system-aarch64 \
  -M none \
  -vnc 127.0.0.1:1 \
  -qmp tcp:127.0.0.1:4444,server,nowait &
```

The GitHub Actions workflow in `.github/workflows/build.yml` performs the
same build on ubuntu-latest, checks that the VNC port is listening, and
publishes the binary as the `qemu-system-aarch64-vnc` artifact.
