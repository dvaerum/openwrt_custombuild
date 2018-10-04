source config.sh

DIR=$(pwd)
IMAGES="$DIR/images"
BUILDS="build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/tmp"

mkdir -p "$IMAGES"

wget https://downloads.lede-project.org/snapshots/targets/ar71xx/tiny/openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
checksum=$(sha256sum openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz)

tar -xf openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64.tar.xz
cd openwrt-imagebuilder-ar71xx-tiny.Linux-x86_64
make image PROFILE="$PROFILE" PACKAGES="$PACKAGES"

if [ "$checksum" -ne "$(cat sha256sum.txt)" ]; then
  echo $checksum > sha256sum.txt
  cp build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/tmp/* "$IMAGES"
  
  git config user.email "$GIT_MAIL"
  git config user.name "$GIT_USER"

  git checkout master
#  git add -A "$IMAGES"/*
  git add -A "sha256sum.txt"
  git commit -m "new updated images"
  git tag -a "$(date +%Y-%m-%d_%H-%M-%S)" -m "new updated images"
  
  git remote add origin-release "https://${GITHUB_TOKEN}@github.com/dvarum12/openwrt_custombuild" > /dev/null 2>&1
  git push --quiet --set-upstream origin-release master --tags
fi
