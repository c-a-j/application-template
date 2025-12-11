#!/bin/bash

fontDir=$(pwd $(dirname $0))
echo $fontDir


tempDir=$(mktemp -d)
cd $tempDir
git clone --filter=blob:none --sparse https://github.com/google/fonts.git
cd fonts
for font in $@; do
  git sparse-checkout set ofl/$font
  mv ofl/$font/*.ttf $fontDir/
done
rm -rf $tempDir
