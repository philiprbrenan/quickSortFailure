apt update 1>/dev/null 2>/dev/null
apt install -y git locales 1>/dev/null 2>/dev/null
mkdir -p /home/phil
export HOME=/home/phil
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
export LANG=en_US.UTF-8
git config --global --add safe.directory /workspace
echo '--- git status ---'
git status

perl quickSort.pl
