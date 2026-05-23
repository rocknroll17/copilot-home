#!/bin/bash
# copilot-bootstrap.sh
#
# Run on a fresh work machine to:
#   1. generate a local SSH key
#   2. get it signed by the hub's CA (issues a 1-year cert)
#   3. install sshfs if missing
#   4. write ~/.copilot-automount and hook it into ~/.bashrc
#   5. mount the hub's copilot-home/{skills,agents,hooks,instructions} into ~/.copilot/
#
# Re-run to renew an expired certificate.

set -euo pipefail

HUB_HOST="__HUB_HOST__"
HUB_USER="__HUB_USER__"
REPO_NAME="__REPO_NAME__"
H="$(hostname)"

echo "→ Setting up $H ..."

# --- 1. SSH key + certificate ----------------------------------------------
if [ ! -s "$HOME/.ssh/id_copilot-cert.pub" ]; then
    echo "[1/5] Issuing SSH certificate from hub..."
    [ -f "$HOME/.ssh/id_copilot" ] || \
        ssh-keygen -t ed25519 -f "$HOME/.ssh/id_copilot" -N "" -C "$H"
    scp -q "$HOME/.ssh/id_copilot.pub" "${HUB_USER}@${HUB_HOST}:/tmp/${H}.pub"
    ssh -t "${HUB_USER}@${HUB_HOST}" "~/bin/sign-copilot $H"
    scp -q "${HUB_USER}@${HUB_HOST}:/tmp/${H}-cert.pub" "$HOME/.ssh/id_copilot-cert.pub"
    ssh "${HUB_USER}@${HUB_HOST}" "rm -f /tmp/${H}.pub /tmp/${H}-cert.pub"
else
    echo "[1/5] Certificate already exists, skipping"
fi

# --- 2. sshfs ---------------------------------------------------------------
echo "[2/5] Checking sshfs..."
if ! command -v sshfs >/dev/null 2>&1; then
    echo "  Installing sshfs (sudo password may be required)..."
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get install -y sshfs
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y fuse-sshfs
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y fuse-sshfs
    elif command -v brew >/dev/null 2>&1; then
        brew install gromgit/fuse/sshfs-mac
    else
        echo "  ✗ Could not detect package manager. Install sshfs manually." >&2
        exit 1
    fi
fi

# --- 3. ~/.copilot-automount -----------------------------------------------
echo "[3/5] Writing ~/.copilot-automount..."
{
echo "HUB_HOST=\"${HUB_HOST}\""
echo "HUB_USER=\"${HUB_USER}\""
echo "REPO_NAME=\"${REPO_NAME}\""
echo 'SRC="${HUB_USER}@${HUB_HOST}:${REPO_NAME}"'
echo 'OPTS="reconnect,ServerAliveInterval=15,ServerAliveCountMax=2,ConnectTimeout=5,IdentityFile=$HOME/.ssh/id_copilot"'
echo ''
echo 'mount_one() {'
echo '    mkdir -p ~/.copilot/$1'
echo '    mountpoint -q ~/.copilot/$1 2>/dev/null && return'
echo '    timeout 10 sshfs "${SRC}/$1" ~/.copilot/$1 -o "$OPTS" 2>/dev/null'
echo '}'
echo ''
echo '# nc 없으면 ssh -o ConnectTimeout=2 로 fallback 체크'
echo 'hub_reachable() {'
echo '    if command -v nc >/dev/null 2>&1; then'
echo '        timeout 2 nc -z "$HUB_HOST" 22 2>/dev/null'
echo '    else'
echo '        ssh -qo BatchMode=yes -o ConnectTimeout=2 -o StrictHostKeyChecking=no "${HUB_USER}@${HUB_HOST}" exit 2>/dev/null'
echo '    fi'
echo '}'
echo ''
echo 'if hub_reachable; then'
echo '    for d in skills agents hooks instructions; do mount_one $d; done'
echo 'fi'
} > "$HOME/.copilot-automount"

# --- 4. .bashrc hook -------------------------------------------------------
echo "[4/5] Registering in ~/.bashrc..."
if ! grep -q ".copilot-automount" "$HOME/.bashrc" 2>/dev/null; then
    echo '[ -f ~/.copilot-automount ] && source ~/.copilot-automount' >> "$HOME/.bashrc"
fi

# --- 5. First mount --------------------------------------------------------
echo "[5/5] First mount (skipped if hub unreachable)..."
# shellcheck disable=SC1091
source "$HOME/.copilot-automount"

echo ""
echo "✅ Setup complete:"
for d in skills agents hooks instructions; do
    printf "  %-15s " "$d:"
    if mountpoint -q "$HOME/.copilot/$d" 2>/dev/null; then
        echo OK
    else
        echo FAIL
    fi
done
