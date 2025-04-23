apt update 1>/dev/null 2>/dev/null
apt install -y git 1>/dev/null 2>/dev/null
mkdir -p /home/phil
export HOME=/home/phil
git config --global --add safe.directory /workspace

echo '--- git status ---'
git status

perl quickSort.pl
