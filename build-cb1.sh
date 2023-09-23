#!/usr/bin/env bash
set -e

pwd

if [[ -f "./src/config" ]]; then
	rm "./src/config"
fi
cat "./config/default" >> ./src/config
cat "./config/armbian/CB1" >> ./src/config
source ./src/config
IMGCOUNT=$(find ./src/image/CB1_Debian11_minimal*.img.xz | wc -l)
if [ "$IMGCOUNT" -eq 0 ]; then
	echo "Downloading image..."
	find ./src/image -type f -not -name '.gitkeep' -delete
	aria2c -d ./src/image --seed-time=0 "$DOWNLOAD_URL_IMAGE"
fi
# exit 0
pushd ./src
sudo bash -x ./build_dist
popd
rm "./src/config"
