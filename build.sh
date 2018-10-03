source config.sh

wget https://downloads.lede-project.org/snapshots/targets/ar71xx/tiny/openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
tar -xf openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
cd openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
make image PROFILE="$PROFILE" PACKAGES="$PACKAGES"
