apt update 1>/dev/null 2>/dev/null
apt install -q -y git locales
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
export LANG=en_US.UTF-8
git config --global --add safe.directory /workspace
echo '--- git status ---'
git status

perl quickSort.pl 2>zzz.txt
