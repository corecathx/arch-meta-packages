#!/usr/bin/env bash
set -e

WORKDIR="/tmp/arch-meta-packages"

if ! pacman -Qi base-devel &>/dev/null; then
    sudo pacman -Sy --noconfirm base-devel
fi
if ! pacman -Qi git &>/dev/null; then
    sudo pacman -Sy --noconfirm git
fi

if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
fi

rm -rf "$WORKDIR"
git clone https://github.com/corecathx/arch-meta-packages.git "$WORKDIR"

cd "$WORKDIR"

for pkg in corecat-meta-base corecat-meta-desktop; do
    cd "$pkg"
    yay -Bi --noconfirm .
    cd ..
done

echo "corecat's arch-meta-packages installed successfully!"