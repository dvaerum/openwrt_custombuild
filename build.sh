source config.sh

DIR=${pwd}
IMAGES="$DIR/images/"

mkdir -p images

wget https://downloads.lede-project.org/snapshots/targets/ar71xx/tiny/openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
tar -xf openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
cd openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
make image PROFILE="$PROFILE" PACKAGES="$PACKAGES"
cp build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/tmp/* "$IMAGES"
