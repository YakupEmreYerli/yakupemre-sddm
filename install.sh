#!/usr/bin/env bash
# Installs yakupemre-sddm into /usr/share/sddm/themes and makes it the active SDDM theme.
# Usage: sudo ./install.sh [--lang en|tr] [--no-activate]
set -euo pipefail

lang=en
activate=1
while [ $# -gt 0 ]; do
    case "$1" in
        --lang) lang="${2:-}"; shift 2 ;;
        --no-activate) activate=0; shift ;;
        -h|--help) sed -n '2,3p' "$0"; exit 0 ;;
        *) echo "Unknown option: $1" >&2; exit 1 ;;
    esac
done

case "$lang" in
    en) config=Themes/en.conf ;;
    tr) config=Themes/tr.conf ;;
    *) echo "Unsupported language: $lang (use en or tr)" >&2; exit 1 ;;
esac

if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root: sudo $0 $*" >&2
    exit 1
fi

src="$(cd "$(dirname "$0")" && pwd)"
dest=/usr/share/sddm/themes/yakupemre-sddm

rm -rf "$dest"
install -d "$dest"
cp -r "$src"/Main.qml "$src"/metadata.desktop "$src"/Components "$src"/Assets \
      "$src"/Backgrounds "$src"/Themes "$src"/LICENSE "$dest"/
sed -i "s#^ConfigFile=.*#ConfigFile=$config#" "$dest/metadata.desktop"

if [ "$activate" -eq 1 ]; then
    install -d /etc/sddm.conf.d
    printf '[Theme]\nCurrent=yakupemre-sddm\n' > /etc/sddm.conf.d/50-yakupemre-sddm.conf
fi

echo "Installed to $dest ($config)."
echo "Preview without logging out: sddm-greeter-qt6 --test-mode --theme $dest"
