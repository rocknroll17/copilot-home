#!/bin/bash
# setup-hub.sh
#
# One-time hub setup. Run on the always-on server that will hold your
# Copilot skills/agents/hooks/instructions truth.
#
# Required env vars:
#   HUB_HOST   - the hostname or IP of this hub as seen from work machines
#                (used inside the bootstrap script that work machines download)
#   HUB_USER   - your username on this hub
#
# Optional env vars:
#   REPO_NAME       - the directory name under $HOME that holds your content
#                     (default: copilot-home)
#   PRINCIPAL       - the user principal to embed in issued SSH certs
#                     (default: same as HUB_USER)
#   CERT_VALIDITY   - cert validity, ssh-keygen -V style (default: +365d)
#   CA_PATH         - where to put the CA private key (default: ~/copilot-ca)
#
# Idempotent: re-running won't duplicate authorized_keys or rebuild the CA.

set -euo pipefail

: "${HUB_HOST:?Set HUB_HOST (e.g. hub.example.com)}"
: "${HUB_USER:?Set HUB_USER (e.g. yourname)}"

REPO_NAME="${REPO_NAME:-copilot-home}"
PRINCIPAL="${PRINCIPAL:-$HUB_USER}"
CERT_VALIDITY="${CERT_VALIDITY:-+365d}"
CA_PATH="${CA_PATH:-$HOME/copilot-ca}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "→ Copilot hub setup"
echo "  HUB_HOST       = $HUB_HOST"
echo "  HUB_USER       = $HUB_USER"
echo "  REPO_NAME      = $REPO_NAME"
echo "  PRINCIPAL      = $PRINCIPAL"
echo "  CERT_VALIDITY  = $CERT_VALIDITY"
echo "  CA_PATH        = $CA_PATH"
echo ""

# --- 1. CA key ---------------------------------------------------------------
if [ ! -f "$CA_PATH" ]; then
    echo "[1/5] Creating SSH CA at $CA_PATH (enter a strong passphrase)..."
    ssh-keygen -t ed25519 -f "$CA_PATH" -C "copilot CA"
    chmod 400 "$CA_PATH"
    chmod 644 "$CA_PATH.pub"
else
    echo "[1/5] CA already exists at $CA_PATH, skipping"
fi

# --- 2. authorized_keys cert-authority --------------------------------------
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys"
chmod 600 "$HOME/.ssh/authorized_keys"

CA_PUB_BODY="$(awk '{print $2}' "$CA_PATH.pub")"
if ! grep -q "$CA_PUB_BODY" "$HOME/.ssh/authorized_keys"; then
    echo "[2/5] Registering CA in ~/.ssh/authorized_keys..."
    echo "cert-authority $(cat "$CA_PATH.pub")" >> "$HOME/.ssh/authorized_keys"
else
    echo "[2/5] CA already in authorized_keys"
fi

# --- 3. sign-copilot ---------------------------------------------------------
echo "[3/5] Installing ~/bin/sign-copilot..."
mkdir -p "$HOME/bin"
sed \
    -e "s|__PRINCIPAL__|$PRINCIPAL|g" \
    -e "s|__VALIDITY__|$CERT_VALIDITY|g" \
    -e "s|__CA_PATH__|$CA_PATH|g" \
    "$SCRIPT_DIR/sign-copilot" > "$HOME/bin/sign-copilot"
chmod +x "$HOME/bin/sign-copilot"

# --- 4. copilot-bootstrap.sh -------------------------------------------------
echo "[4/5] Installing ~/copilot-bootstrap.sh..."
sed \
    -e "s|__HUB_HOST__|$HUB_HOST|g" \
    -e "s|__HUB_USER__|$HUB_USER|g" \
    -e "s|__REPO_NAME__|$REPO_NAME|g" \
    "$SCRIPT_DIR/copilot-bootstrap.sh" > "$HOME/copilot-bootstrap.sh"
chmod +x "$HOME/copilot-bootstrap.sh"

# --- 5. ~/bin in PATH --------------------------------------------------------
if ! echo ":$PATH:" | grep -q ":$HOME/bin:"; then
    echo "[5/5] Adding \$HOME/bin to PATH in ~/.bashrc..."
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
else
    echo "[5/5] \$HOME/bin already on PATH"
fi

cat <<EOF

✅ Hub setup complete.

On any work machine:
  scp $HUB_USER@$HUB_HOST:~/copilot-bootstrap.sh /tmp/copilot-bootstrap.sh && bash /tmp/copilot-bootstrap.sh

EOF
